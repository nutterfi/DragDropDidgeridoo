//
//  Card.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//


import SwiftUI
import UniformTypeIdentifiers
import Shapes

enum Suit: String, Hashable, Codable {
  case heart
  case club
  case diamond
  case spade
  
  var image: Image {
    switch self {
    case .heart:
      Image(systemName: "heart.fill")
    case .club:
      Image(systemName: "suit.club.fill")
    case .diamond:
      Image(systemName: "diamond.fill")
    case .spade:
      Image(systemName: "suit.spade.fill")
    }
  }
}

enum Rank: String, Hashable, Codable {
  case ace = "A"
  case two = "2"
  case three = "3"
  case four = "4"
  case five = "5"
  case six = "6"
  case seven = "7"
  case eight = "8"
  case nine = "9"
  case ten = "10"
  case jack = "J"
  case queen = "Q"
  case king = "K"
}


// Conformance of 'Card' to protocol 'Transferable' crosses into main actor-isolated code and can cause data races; this is an error in the Swift 6 language mode
nonisolated struct Card: Hashable, Sendable, Codable {
  var rank: Rank
  var suit: Suit
}

extension UTType {
    static var card = UTType(exportedAs: "com.nutterfi.card")
}

extension Card: Transferable {
  static var transferRepresentation: some TransferRepresentation {
    CodableRepresentation(contentType: .card)
  }
}

extension Card {
  static var upper: [Card] {
    [
      Card(rank: .ace, suit: .club),
      Card(rank: .five, suit: .heart),
      Card(rank: .nine, suit: .spade),
      Card(rank: .jack, suit: .diamond)
    ]
  }
  static var lower: [Card] {
    [
      Card(rank: .seven, suit: .heart),
      Card(rank: .three, suit: .club),
      Card(rank: .king, suit: .diamond),
      Card(rank: .queen, suit: .spade),
    ]
  }
}
