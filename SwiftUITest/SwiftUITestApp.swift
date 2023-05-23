//
//  SwiftUITestApp.swift
//  SwiftUITest
//
//  Created by Мельник Дмитрий on 17.05.2023.
//

import SwiftUI

@main
struct SwiftUITestApp: App {
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(order)
        }
    }
}
