//
//  DetailUserViewModel.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 26.05.26.
//

import Foundation

@Observable
final class DetailUserViewModel {
    private(set) var detailUserObject: DetailUserResponse?
    private(set) var isLoading = false
    private(set) var error: NetworkingManager.NetworkingError?
    var hasError = false

    private let networkingManager : NetworkingManagerImpl!

    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    @MainActor
    func fetchUserDetails(for id: String) async {
        isLoading = true
        defer { isLoading = false}

        do {
            detailUserObject = try await networkingManager
                .authorizedRequest(
                    session: .shared,
                    .detailUser(id: id)
            )
        } catch  {
            hasError = true
            self.error = error as? NetworkingManager.NetworkingError ??
                .custom(error: error.localizedDescription)
        }
    }
}
