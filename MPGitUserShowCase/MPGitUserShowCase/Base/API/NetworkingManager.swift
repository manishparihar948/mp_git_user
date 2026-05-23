//
//  NetworkingManager.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import Foundation

protocol NetworkingManagerImpl {
    func authorizedRequest<T: Codable> (session:URLSession,
                                        _ endpoint: Endpoint,
                                        type: T.Type) async throws -> T
}

final class NetworkingManager: NetworkingManagerImpl {

    static let shared = NetworkingManager()

    private init() {}

    // Handles Only Get Request
    func authorizedRequest<T: Codable> (session:URLSession = .shared,
                                        _ endpoint: Endpoint,
                                        type: T.Type) async throws -> T {
        /*
        // Read API key securely
        guard let apiKey = KeychainHelper.read(key: Secrets.apiKeyIdentifier),
              !apiKey.isEmpty else {
            throw NetworkingError.custom(error: NSError( domain: "NetworkingManager",
                                                         code: -1,
                                                         userInfo: [NSLocalizedDescriptionKey: "Missing API key"] ))


        }
         */

        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }

        /*
        let request = buildRequest(from: url,
                                   methodType: endpoint.methodType,
                                   headers: [ "Content-Type": "application/json", "x-api-key": apiKey ])
         */

        let request = buildRequest(from: url,
                                   methodType: endpoint.methodType,
                                   headers: ["Content-Type": "application/json"])

        let (data , response) = try await session.data(
            for: request)
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
    }
}


extension NetworkingManager {
    enum NetworkingError : LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        case .invalidStatusCode:
            return "Status code falls into wrong range"
        case .invalidData:
            return "Return data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        }
    }
}

extension NetworkingManager {
    func buildRequest(from url:URL,
                      methodType:Endpoint.MethodType,
                      headers: [String: String] = [:]) -> URLRequest {
        var request = URLRequest(url: url)

        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        // Default Content-Type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        /*
        // Merge custom headers (e.g. x-api-key)
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        */

        return request
    }
}

