//
//  UserViewModel.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 24.05.26.
//

import Foundation

@MainActor
@Observable
final class UserViewModel {
    private(set) var usersObject: [Users] = []
    private(set) var loadPhase: LoadPhase = .idle
    private(set) var error: NetworkingManager.NetworkingError?
    var hasError = false

    var isLoading : Bool { loadPhase == .loading }
    var isFetching : Bool { loadPhase == .fetching }

    private let  networkingManager : any NetworkingManagerImpl

    init(networkingManager: any NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    func fetchGitUsersList() async {
        reset()
        loadPhase = .loading
        defer { loadPhase = .idle }

        do {
            let response : [Users] = try await networkingManager.authorizedRequest(.users)
            self.usersObject = response

            // Temporary debug
            response.prefix(3).forEach {
                print("👤 \($0.login) → avatarURL: \($0.avatarUrl ?? "NIL")")
            }
        } catch {
            hasError = true
            self.error = error as? NetworkingManager.NetworkingError ??
                .custom(error: error)
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
