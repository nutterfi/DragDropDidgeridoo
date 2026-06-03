//
//  DragDropDidgeridooApp.swift
//  DragDropDidgeridoo
//
//  Created by nutterfi on 6/2/26.
//

import SwiftUI

@main
struct DragDropDidgeridooApp: App {
  @State private var dataModel = DataModel()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(dataModel)
    }
  }
}
