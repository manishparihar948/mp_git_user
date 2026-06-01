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
    private(set) var loadPhase: LoadPhase = .idle
    private(set) var error: NetworkingManager.NetworkingError?
    var hasError = false

    var isLoading : Bool { loadPhase == .loading }
    var isFetching : Bool { loadPhase == .fetching }

    private let networkingManager : NetworkingManagerImpl!

    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }

    @MainActor
    func fetchUserDetails(for id: String) async {
        loadPhase = .loading
        defer { loadPhase = .idle}

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


extension DetailUserViewModel {
    enum LoadPhase: Equatable {
        case idle
        case loading
        case fetching
    }
}
