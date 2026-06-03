//
//  ContentView.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//

import SwiftUI

@Observable
class DataModel {
  var upperStrings: [String] = ["A", "B", "C", "D"]
  var lowerStrings: [String] = ["W", "X", "Y", "Z"]
  
  func handleUpperDestinationDroppedItems(_ items: [String]) {
    print("Dropped Item Upper: \(items)")
    items.forEach { item in
      if !upperStrings.contains(item) {
        upperStrings.append(item)
        // assume it came from lower
        lowerStrings.removeAll(where: { $0 == item} )
      }
    }
  }
  
  func handleLowerDestinationDroppedItems(_ items: [String]) {
    print("Dropped Item Lower: \(items)")
    items.forEach { item in
      if !lowerStrings.contains(item) {
        lowerStrings.append(item)
        // assume it came from upper
        upperStrings.removeAll(where: { $0 == item} )
      }
    }
  }
}

struct ContentView: View {
  @Environment(DataModel.self) private var dataModel
  
    var body: some View {
      VStack {
        ScrollView {
          ForEach(dataModel.upperStrings.indices, id: \.self) { index in
            Color.red.frame(height: 80)
              .overlay {
                Text(dataModel.upperStrings[index])
                  .font(.largeTitle.weight(.semibold))
                  .foregroundStyle(.white)
              }
              .draggable(dataModel.upperStrings[index])
          }
        }
        .dropDestination(for: String.self) { items, offset in
          dataModel.handleUpperDestinationDroppedItems(items)
        }
        
        ScrollView {
          ForEach(dataModel.lowerStrings.indices, id: \.self) { index in
            Color.blue.frame(height: 80)
              .overlay {
                Text(dataModel.lowerStrings[index])
                  .font(.largeTitle.weight(.semibold))
                  .foregroundStyle(.white)
              }
              .draggable(dataModel.lowerStrings[index])
          }
        }
        .dropDestination(for: String.self) { items, offset in
          dataModel.handleLowerDestinationDroppedItems(items)
        }
      }
      .padding()
    }
}

#Preview {
    ContentView()
    .environment(DataModel())
}
