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
  
  var color: Color {
    switch card.suit {
    case .heart:
        .red
    case .club:
        .black
    case .diamond:
        .red
    case .spade:
        .black
    }
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.white)
        .stroke(Color.black)
      
      card.suit.image
        .foregroundStyle(color)
    }
    .overlay(alignment: .topLeading) {
      Text(card.rank.rawValue)
        .padding()
    }
    .font(.largeTitle.weight(.semibold))
    .aspectRatio(0.5, contentMode: .fit)
  }
}

#Preview {
  CardView(card: .init(rank: .ace, suit: .spade))
}
