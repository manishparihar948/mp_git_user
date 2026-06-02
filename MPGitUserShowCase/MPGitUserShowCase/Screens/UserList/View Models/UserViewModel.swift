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
    private(set) var viewState: ViewState?
    private(set) var error: NetworkingManager.NetworkingError?
    var hasError = false

    var isLoading : Bool { viewState == .loading }
    var isFetching : Bool { viewState == .feching }

    private let  networkingManager : NetworkingManagerImpl!

    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    @MainActor
    func fetchGitUsersList() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }

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
        if viewState == .finished {
            usersObject.removeAll()
            error = nil
            viewState = nil
        }
    }
}

extension UserViewModel {
    enum ViewState: Equatable {
        case feching
        case loading
        case finished
    }
}
