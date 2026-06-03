//
//  CardView.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//


import SwiftUI
import Shapes

struct CardView: View {
  let card: Card
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.white)
        .stroke(Color.black)
      
      Text(card.suit.rawValue)
        .foregroundStyle(Color.red)
    }
    .overlay(alignment: .topLeading) {
      Text(card.rank.rawValue)
      
    }
    .font(.largeTitle.weight(.semibold))
    .aspectRatio(0.5, contentMode: .fit)
  }
}

#Preview {
  CardView(card: .init(rank: .ace, suit: .spade))
}
