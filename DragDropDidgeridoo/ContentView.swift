//
//  ContentView.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//

import SwiftUI
import Shapes

@Observable
class DataModel {
  var upperCards: [Card] = Card.upper
  var lowerCards: [Card] = Card.lower
  
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
  let columns = Array(repeating: GridItem(), count: 3)
  
    var body: some View {
      VStack {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(dataModel.upperCards.indices, id: \.self) { index in
              CardView(card: dataModel.upperCards[index])
                .containerRelativeFrame(.horizontal) { length, _ in
                  length / Double(columns.count) - 5
                }
                .draggable(dataModel.upperCards[index])
            }
          }
        }
        .contentMargins(10)
        .background {
          Color.red
        }
        .dropDestination(for: Card.self) { items, offset in
          dataModel.handleUpperDestinationDroppedItems(items)
        }
        
        ScrollView {
          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(dataModel.lowerCards.indices, id: \.self) { index in
              CardView(card: dataModel.lowerCards[index])
                .containerRelativeFrame(.horizontal) { length, _ in
                  length / Double(columns.count) - 5
                }
                .draggable(dataModel.lowerCards[index])
            }
          }
        }
        .contentMargins(10)
        .background {
          Color.yellow
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
