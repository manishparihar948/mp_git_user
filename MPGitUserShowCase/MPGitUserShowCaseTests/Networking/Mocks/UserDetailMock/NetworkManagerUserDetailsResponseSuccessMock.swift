//
//  NetworkManagerUserDetailsResponseSuccessMock.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 03.06.26.
//

#if DEBUG
import Foundation
@testable import MPGitUserShowCase

class NetworkManagerUserDetailsResponseSuccessMock: NetworkingManagerImpl {

    func authorizedRequest<T>(session: URLSession, _ endpoint: MPGitUserShowCase.Endpoint) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper
            .decode(file: "SingleUserData", type: DetailUserResponse.self) as! T
    }

    func authorizedRequest(session: URLSession, _ endpoint: MPGitUserShowCase.Endpoint) async throws {
    }
}

#endif
