//
//  NetworkManagerUserDetailsResponseFailureMock.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 03.06.26.
//

#if DEBUG

import Foundation
@testable import MPGitUserShowCase

class NetworkManagerUserDetailsResponseFailureMock: NetworkingManagerImpl {
    func authorizedRequest<T>(session: URLSession, _ endpoint: MPGitUserShowCase.Endpoint) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }

    func authorizedRequest(session: URLSession, _ endpoint: MPGitUserShowCase.Endpoint) async throws {}
}

#endif
