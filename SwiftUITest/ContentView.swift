//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Мельник Дмитрий on 17.05.2023.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                List {
                    ForEach(menu) { section in
                        Section(section.name) {
                            Text(section.name)
                            ForEach(section.items) { items in
                                ItemRow(item: items)
                            }
                        }
                    }
                }
                .navigationDestination(for: MenuItem.self, destination: { item in
                    ItemDetail(item: item)
                })
                
                .navigationTitle("If IOS >= 16")
                .listStyle(GroupedListStyle())
            } else {
                // Fallback on earlier versions
                List {
                    ForEach(menu) { section in
                        Section(section.name) {
                            Text(section.name)
                            ForEach(section.items) { items in
                                NavigationLink(destination: ItemDetail(item: items)) {
                                    ItemRow(item: items)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("If IOS <= 16")
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
