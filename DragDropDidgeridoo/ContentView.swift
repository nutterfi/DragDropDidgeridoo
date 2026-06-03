//
//  ContentView.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//

import SwiftUI
import UniformTypeIdentifiers


struct Card: Hashable, Sendable {
  var value: String
}

extension UTType {
    static var card = UTType(exportedAs: "com.nutterfi.card")
}

extension Card: Transferable {
  static var transferRepresentation: some TransferRepresentation {
    ProxyRepresentation { card in
      card.value
    } importing: { value in
      Card(value: value)
    }
  }
}

@Observable
class DataModel {
  var upperCards: [Card] = ["A", "B", "C", "D"].map {Card(value: $0)}
  var lowerCards: [Card] = ["W", "X", "Y", "Z"].map {Card(value: $0)}
  
  func handleUpperDestinationDroppedItems(_ items: [Card]) {
    print("Dropped Item Upper: \(items)")
    items.forEach { item in
      if !upperCards.contains(item) {
        upperCards.append(item)
        // assume it came from lower
        lowerCards.removeAll(where: { $0 == item} )
      }
    }
  }
  
  func handleLowerDestinationDroppedItems(_ items: [Card]) {
    print("Dropped Item Lower: \(items)")
    items.forEach { item in
      if !lowerCards.contains(item) {
        lowerCards.append(item)
        // assume it came from upper
        upperCards.removeAll(where: { $0 == item} )
      }
    }
  }
}

struct ContentView: View {
  @Environment(DataModel.self) private var dataModel
  
    var body: some View {
      VStack {
        ScrollView {
          ForEach(dataModel.upperCards.indices, id: \.self) { index in
            Color.red.frame(height: 80)
              .overlay {
                Text(dataModel.upperCards[index].value)
                  .font(.largeTitle.weight(.semibold))
                  .foregroundStyle(.white)
              }
              .draggable(dataModel.upperCards[index])
          }
        }
        .dropDestination(for: Card.self) { items, offset in
          dataModel.handleUpperDestinationDroppedItems(items)
        }
        
        ScrollView {
          ForEach(dataModel.lowerCards.indices, id: \.self) { index in
            Color.yellow.frame(height: 80)
              .overlay {
                Text(dataModel.lowerCards[index].value)
                  .font(.largeTitle.weight(.semibold))
                  .foregroundStyle(.white)
              }
              .draggable(dataModel.lowerCards[index])
          }
        }
        .dropDestination(for: Card.self) { items, offset in
          dataModel.handleLowerDestinationDroppedItems(items)
        }
      }
      .padding()
    }
}

#Preview {
  @Previewable @State var dataModel = DataModel()
    ContentView()
    .environment(dataModel)
}
