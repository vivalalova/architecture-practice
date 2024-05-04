//
//  ContentView.swift
//  architecture-practice
//
//  Created by Lova on 2024/3/18.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var numberFact: String?
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }

    @Dependency(\.numberFact) var numberFactClient

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .numberFactButtonTapped:
                return .run { [count = state.count] send in

                    let string = try await self.numberFactClient.fetch(count)

                    await send(.numberFactResponse(string))
                }
            case let .numberFactResponse(fact):
                state.numberFact = fact
                return .none
            }
        }
    }
}

struct ContentView: View {
    let store: StoreOf<AppFeature>

    var body: some View {
        Form {
            Section {
                Text("\(self.store.count)")
                Button("Decrement") { self.store.send(.decrementButtonTapped) }
                Button("Increment") { self.store.send(.incrementButtonTapped) }
            }

            Section {
                Button("Number fact") { self.store.send(.numberFactButtonTapped) }
            }

            if let fact = store.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() }
        )
    )
}
