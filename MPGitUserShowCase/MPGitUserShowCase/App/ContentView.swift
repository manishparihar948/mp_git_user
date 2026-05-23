//
//  ContentView.swift
//  MPGitUserShowCase
//
//  Created by Manish Parihar on 20.05.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @Environment(ThemeManager.self) private var themeManager: ThemeManager

    @State private var showThemes = false

    var body: some View {
        /*
         NavigationSplitView {
         List {
         ForEach(items) { item in
         NavigationLink {
         Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
         } label: {
         Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
         }
         }
         .onDelete(perform: deleteItems)
         }
         .toolbar {
         ToolbarItem(placement: .navigationBarTrailing) {
         EditButton()
         }
         ToolbarItem {
         Button(action: addItem) {
         Label("Add Item", systemImage: "plus")
         }
         }
         }
         } detail: {
         Text("Select an item")
         }
         */

        ZStack {

            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)

                Text("Hello GitUser!")
                    .padding()
                    .onAppear {
                        print("User Response")
                        dump(
                            try? StaticJSONMapper
                                .decode(
                                    file: "StaticUserListData",
                                    type: UsersResponse.self)
                        )
                    }
                    .padding()

            }
            Spacer()
            Rectangle().fill(themeManager.selectedTheme.gradient)
            VStack {
                Button("Show Themes") {
                    showThemes.toggle()
                }
                .font(.system(.headline,
                              design: .rounded,
                              weight: .bold))
                .buttonStyle(.bordered)
                .foregroundStyle(.white)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle)
            }
        }
        .animation(.bouncy, value: themeManager.selectedTheme)
        .ignoresSafeArea()
        .sheet(isPresented: $showThemes, content: {
            ThemeSwitcherView()
                .presentationDetents([.medium])
        })
    }

    /*
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
     */
}

#Preview {
    ContentView()
        // .modelContainer(for: Item.self, inMemory: true)
        .environment(ThemeManager())

}
