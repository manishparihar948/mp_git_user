//
//  NetworkingManagerUserListResponseFailureMock.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 02.06.26.
//

#if DEBUG
import Foundation
@testable import MPGitUserShowCase

class NetworkingManagerUserListResponseFailureMock: NetworkingManagerImpl {
    func authorizedRequest<T>(session: URLSession, _ endpoint: Endpoint) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }

    func authorizedRequest(session: URLSession, _ endpoint: Endpoint) async throws {}
}

#endif
