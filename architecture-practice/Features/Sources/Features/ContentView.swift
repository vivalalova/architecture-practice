//
//  ContentView.swift
//  architecture-practice
//
//  Created by Lova on 2024/3/18.
//

import SwiftUI

public
struct ContentView: View {
    public init() {}

    public
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
