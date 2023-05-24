//
//  ItemDetail.swift
//  SwiftUITest
//
//  Created by Мельник Дмитрий on 24.05.2023.
//

import SwiftUI


struct ItemDetail: View {
    @State private var isShowingOverView = false
    var item: MenuItem
    @EnvironmentObject var order: Order
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
                //                Text(item.description)
                //                    .padding()
                //                Spacer()
            }
            //            Image(item.mainImage)
            Text(item.description)
                .padding()
            Button("Add to order") {
                order.add(item: item)
                //                OrderView()
            }
            .buttonStyle(.borderedProminent)
            NavigationLink("j") {
                OrderView()
            } //label: {
//                Text("$ \(item.price)")
//            }
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ItemDetail(item: MenuItem.example).environmentObject(Order())
            }
        } else {
            ItemDetail(item: MenuItem.example).environmentObject(Order())
        }
    }
}
