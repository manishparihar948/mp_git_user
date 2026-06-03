//
//  NetworkingManagerUserResponseSuccessMock.swift
//  MPGitUserShowCaseTests
//
//  Created by Manish Parihar on 02.06.26.
//

#if DEBUG
import Foundation
@testable import MPGitUserShowCase

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {

    func authorizedRequest<T>(session: URLSession, _ endpoint: Endpoint) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper
            .decode(file: "StaticUserListData", type: [Users].self) as! T

    }

    func authorizedRequest(session: URLSession, _ endpoint: Endpoint) async throws {}
}

#endif

