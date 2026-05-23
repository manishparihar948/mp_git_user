//
//  UserItemView.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI

struct UserItemView: View {
    let user: Users

    var body: some View {
        VStack(spacing: .zero) {
            Text("\(user.login)")
                .font(
                    .system(.body, design: .rounded)
                )
        }
    }
}
