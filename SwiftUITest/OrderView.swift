//
//  OrderView.swift
//  SwiftUITest
//
//  Created by Мельник Дмитрий on 24.05.2023.
//

import SwiftUI


struct OrderView: View {
    //    var item: MenuItem
    @EnvironmentObject var order: Order
    var body: some View {
        List {
            ForEach(order.items) { item in
                Text("\(item.name)")
                NavigationLink(destination: ItemDetail(item: item)) {
                    ItemRow(item: item)
                }
            }
        }
        .navigationTitle("Orders")
        .listStyle(GroupedListStyle())
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        
        OrderView().environmentObject(Order())
    }
}
