//
//  ContentView.swift
//  ProfileUI
//  Created by MD Tarif khan on 18/7/22.


import SwiftUI

struct Item: Identifiable{
    let id = UUID()
    let title: String
    let image: String
}

struct ContentView: View {
    
    let items = [
        Item(title: "Home", image: "home"),
        Item(title: "Money", image: "money"),
        Item(title: "Bank", image: "bank"),
        Item(title: "Vaction", image: "vaction"),
        Item(title: "User", image:"user"),
        Item(title: "Charts", image: "chart"),
        Item(title: "Support", image: "support"),
        Item(title: "Book", image: "book")
    ]
    
    let spacing: CGFloat = 10
    @State private var  numberOfColumns = 2
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing),count: numberOfColumns)
                            
        ScrollView{
            
            headerView
            
            LazyVGrid(columns: columns, spacing: spacing){
                ForEach(items){ item in
                    Button(action:{}){
                        ItemView(item: item)
                    }
                    .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            .offset(y: -50)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
    var headerView: some View{
        VStack{
            Image("profile")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .onTapGesture {
                    numberOfColumns = numberOfColumns % 4 + 1
                }
            
            Text("MD Tarif khan")
                .foregroundColor(Color.white)
                .font(.system(size: 30, weight: .bold, design: .serif))
            Text("Click on the image for change the grid style.")
                .foregroundColor(Color.white.opacity(0.8))
                .font(.system(size: 18, weight: .medium, design: .serif))
                .multilineTextAlignment(.center)
        }
        .frame(height: 400)
        .frame(maxWidth: .infinity)
        .background(Color.brown)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.4), radius: 10, y: 5)

    }

}

struct ItemButtonStyle: ButtonStyle{
    let cornerRadius: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            configuration.label
            if configuration.isPressed{
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}


struct ItemView: View{
    let item: Item
    
    var body: some View{
        GeometryReader{ reader in
            
            //now we make this view more dynamic, so that the text and the image always fit the views dimensions!
            let fontSize = min(reader.size.width * 0.2, 22)
            let imageSize:CGFloat = min(50, reader.size.width * 0.6)
            
            VStack(spacing: 5){
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                     .frame(width: imageSize)
                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design: .serif))
                    .foregroundColor(Color.black.opacity(0.8))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)

        }
        .frame(height: 150)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
