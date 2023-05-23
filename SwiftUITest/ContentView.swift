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
//                                ItemRow(item: items)
                            }
                        }
                    }
                }
                .navigationTitle("If IOS <= 16")
                .listStyle(GroupedListStyle())
            }
        }
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundColor(.accentColor)
        //            Text("Hello, world!")
        //        }
        //        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ItemRow : View {
    let item: MenuItem
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(.gray, lineWidth: 2))
            VStack(alignment: .leading) {
                if #available(iOS 16.0, *) {
                    NavigationLink(value: item) {
                        ItemRow(item: item)
                        //                    ItemDetail(item: item)
                        Text(item.name)
                            .font(.headline)
                    }
                } else {
                    NavigationLink {
                        ItemDetail(item: item)
                        Text(item.name)
                            .font(.headline)
                    } label: {
                        Text("$ \(item.price)")
                    }
                }
                Spacer()
                ForEach(item.restrictions, id: \.self) { restriction in
                    Text(restriction)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(5)
                        .background(colors[restriction, default: .black])
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
            
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}

struct ItemDetail: View {
    var item: MenuItem
    
    var body: some View {
        VStack {
            Image(item.mainImage)
            Text(item.description)
        }
        .navigationTitle(item.name)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ItemRow(item: MenuItem.example)
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
