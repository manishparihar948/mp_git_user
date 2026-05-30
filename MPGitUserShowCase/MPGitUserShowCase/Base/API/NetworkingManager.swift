//
//  NetworkingManager.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import Foundation

@preconcurrency
protocol NetworkingManagerImpl: Sendable {
    func authorizedRequest<T: Codable> (session:URLSession,
                                        _ endpoint: Endpoint,
                                        type: T.Type) async throws -> T

    func authorizedRequest(session: URLSession,
                           _ endpoint: Endpoint) async throws
}

@MainActor

final class NetworkingManager: NetworkingManagerImpl, Sendable {

    static let shared = NetworkingManager()

    private init() {}

    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()

    // Handles Only Get Request
    @preconcurrency
    func authorizedRequest<T: Codable> (session: URLSession = .shared,
                                        _ endpoint: Endpoint,
                                        type: T.Type) async throws -> T {
        let request = try authorizedURLRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)
        try validate(response: response)

        do {
            return try Self.decoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.failedToDecode(error: error)
        }
    }

    func authorizedRequest(session: URLSession = .shared,
                 _ endpoint: Endpoint) async throws {

        let request = try authorizedURLRequest(for: endpoint)
        let (_, response) = try await session.data(for: request)
        try validate(response: response)

    }


    private func authorizedURLRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        return buildRequest(
            url: url,
            method:endpoint.methodType
        )
    }

    private func validate(response: URLResponse) throws {
        guard
            let http = response as? HTTPURLResponse
        else { throw NetworkingError.invalidResponse}

        guard(200..<300).contains(http.statusCode) else {
            throw NetworkingError.invalidStatusCode(statusCode: http.statusCode)
        }
    }
}

private func buildRequest(url: URL,
                          method: Endpoint.MethodType)  -> URLRequest {
    var request = URLRequest(url: url)
    switch  method {
    case .get:
        request.httpMethod = "GET"
    }
    return request
}

// MARK: - Errors
extension NetworkingManager {
    enum NetworkingError: LocalizedError, Sendable {
        case invalidURL
        case invalidResponse
        case missingAPIKey
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: any Error)
        case custom(error: any Error)

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                "The URL is invalid"
            case .invalidResponse:
                "The server returned an unexpected response"
            case .missingAPIKey:
                "API key is missing from Keychain"
            case .invalidStatusCode(let code):
                "Unexpected status code: \(code)."
            case .invalidData:
                "The response data was invalid"
            case .failedToDecode(let err):
                "Decoding failed: \(err.localizedDescription)"
            case .custom(let err):
                "An error occured: \(err.localizedDescription)"
            }
        }
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.missingAPIKey, .missingAPIKey):
            return true
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}
