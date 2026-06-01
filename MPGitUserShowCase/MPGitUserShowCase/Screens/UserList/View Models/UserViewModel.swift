//
//  UserViewModel.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 24.05.26.
//

import Foundation


@Observable
final class UserViewModel {
    private(set) var usersObject: [Users] = []
    private(set) var loadPhase: LoadPhase = .idle
    private(set) var error: NetworkingManager.NetworkingError?
    var hasError = false

    var isLoading : Bool { loadPhase == .loading }
    var isFetching : Bool { loadPhase == .fetching }

    private let  networkingManager : NetworkingManagerImpl!

    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    @MainActor
    func fetchGitUsersList() async {
        reset()
        loadPhase = .loading
        defer { loadPhase = .idle }

        do {
            let response : [Users] = try await networkingManager.authorizedRequest(
                session: .shared,
                .users)
            self.usersObject = response
            
        } catch {
            hasError = true
            self.error = error as? NetworkingManager.NetworkingError ??
                .custom(error: error.localizedDescription)
        }
    }

    private func reset() {
        usersObject.removeAll()
        error = nil
        hasError = false
        loadPhase = .idle
    }

}

extension UserViewModel {
    enum LoadPhase: Equatable {
        case idle
        case loading
        case fetching
    }
}
