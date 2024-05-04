//
//  File.swift
//
//
//  Created by Lova on 2024/5/5.
//

import ComposableArchitecture
import SwiftUI

@main
struct APP: App {
    var body: some Scene {
        let store = Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )

        WindowGroup {
            ContentView(store: store)
        }
    }
}
