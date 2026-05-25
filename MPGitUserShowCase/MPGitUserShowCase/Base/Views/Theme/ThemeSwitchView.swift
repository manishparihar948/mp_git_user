//
//  ThemeSwitchView.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 23.05.26.
//

import SwiftUI
import Observation

let colors: [Color] = [
    .red,
    .green,
    .yellow,
    .blue,
    .purple,
    .pink,
    .cyan,
    .indigo,
    .mint,
    .orange,
    .teal
]

@Observable
class ThemeManager {
    var selectedTheme : Color = .green
}

struct ThemeSwitcherView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 0),
        count: 4
    )

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Text("Select A Theme")
                    .font(.system(.title, design: .rounded, weight: .bold))

                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(colors, id: \.hashValue) {
                        color in
                        Button(action: {
                            themeManager.selectedTheme = color
                        }, label: {
                            GradientView(color: color, isActive:themeManager.selectedTheme == color)
                        })
                    }
                }
                .padding(.vertical, 32)
                .background(Color(uiColor: .systemGray6), in: RoundedRectangle(cornerRadius: 15))
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .toolbar(content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.fill.circle)
                        .font(.system(.title,
                                      design: .rounded,
                                      weight: .bold))
                        .foregroundStyle(Color(uiColor:.systemGray3))
                })
                .buttonStyle(.plain)
            })
        }
    }
}

#Preview {
    ThemeSwitcherView()
        .environment(ThemeManager())
}
