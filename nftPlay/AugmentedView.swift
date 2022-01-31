//
//  AugmentedView.swift
//  nftPlay
//
//  Created by Razib Mollick on 1/30/22.
//

import SwiftUI

// MARK: - AR
struct AugmentedView: View {
   @State var flippedCard: Int?
   @State var frontCard: Int?
    var cards: [NFTItem]
    
    init(cards: [NFTItem]) {
        self.cards = cards
    }
   
   var body: some View {
      let columns = [
         GridItem(.flexible(), spacing: 0),
         GridItem(.flexible(), spacing: 0),
         GridItem(.flexible(), spacing: 0)
      ]
      
      GeometryReader { screenGeometry in
         ZStack {
            ScrollView {
               LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                  ForEach(cards, id: \.id) { card in
                      let isFaceUp = flippedCard == card.id
                     GeometryReader { cardGeometry in
                        ZStack {
                           CardBackView(card: card)
                              .modifier(FlipOpacity(pct: isFaceUp ? 0 : 1))
                              .rotation3DEffect(Angle.degrees(isFaceUp ? 180 : 360), axis: (0,1,0))
                              .frame(width: cardGeometry.size.width, height: cardGeometry.size.height)
                              .scaleEffect(isFaceUp ? screenGeometry.size.width / cardGeometry.size.width: 1)
                           CardFrontView(card: card)
                              .modifier(FlipOpacity(pct: isFaceUp ? 1 : 0))
                              .rotation3DEffect(Angle.degrees(isFaceUp ? 0 : 180), axis: (0,1,0))
                              .frame(width: screenGeometry.size.width, height: screenGeometry.size.height)
                              .scaleEffect(isFaceUp ? 1 : cardGeometry.size.width / screenGeometry.size.width)
                        }
                        .offset(x: isFaceUp ? -cardGeometry.frame(in: .named("mainFrame")).origin.x: -screenGeometry.size.width/2 + cardGeometry.size.width/2,
                                y: isFaceUp ? -cardGeometry.frame(in: .named("mainFrame")).origin.y: -screenGeometry.size.height/2 + cardGeometry.size.height/2)
                        .onTapGesture {
                           withAnimation(.linear(duration: 1.0)) {
                              if flippedCard == nil {
                                  flippedCard = card.id
                                  frontCard = card.id
                              } else if flippedCard == card.id {
                                 flippedCard = nil
                              }
                           }
                        }
                     }
                     .aspectRatio(1, contentMode: .fit)
                     .zIndex(frontCard == card.id ? 1 : 0)
                  }
               }
            }
         }
         .background(Color.black)
      }
      .coordinateSpace(name: "mainFrame")
   }
}

// MARK: - Flip
struct FlipOpacity: AnimatableModifier {
   var pct: CGFloat = 0
   
   var animatableData: CGFloat {
      get { pct }
      set { pct = newValue }
   }
   
   func body(content: Content) -> some View {
      return content.opacity(Double(pct.rounded()))
   }
}

// MARK: - Back NFT
struct CardBackView: View {
   var card: NFTItem
   
   var body: some View {
      ZStack {
         RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
            .padding(5)
          VStack{
              Image("\(card.imageName)")
                  .resizable()
                  .frame(width: 70, height: 80, alignment: .center)
              Text(card.name)
          }
      }
   }
}

// MARK: - Front NFT
struct CardFrontView: View {
   var card: NFTItem
   
   var body: some View {
      ZStack {
         RoundedRectangle(cornerRadius: 10)
            .fill(Color.green)
            .padding(10)
            .aspectRatio(1.0, contentMode: .fit)
          VStack{
              Text(card.slug).padding()
              Button(action: {
                  
              }){
                  Text("Go to AR View - TBD")
              }
          }
         
      }
   }
}


struct AugmentedView_Previews: PreviewProvider {
    static var previews: some View {
        AugmentedView(cards: NFTItem.testData)
    }
}

// MARK: - Mock Data
//============= MOCK TEST DATA ======================
struct NFTItem {
    let id: Int
    let name: String
    let slug: String
    let imageName: String
}

extension NFTItem {
    static var testData: [NFTItem] {
            return [
                NFTItem(id: 1, name: "School", slug: "Do you want to see this Picture in your wall, Please continue to detact the plain wall", imageName: "rioschool"),
                NFTItem(id: 2, name: "HBD", slug: "Do you want to see this Picture in your wall, Please continue to detact the plain wall", imageName: "riobd")
            ]
    }
}
