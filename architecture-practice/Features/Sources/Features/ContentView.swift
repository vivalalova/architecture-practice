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
        var numberDate: String?
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String, String)
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
                state.numberFact = "loading..."
                state.numberDate = "loading..."

                return .run { [count = state.count] send in
                    let string = try await self.numberFactClient.trivia(count)
                    let string2 = try await self.numberFactClient.date(count)

                    await send(.numberFactResponse(string, string2))
                }
            case let .numberFactResponse(fact, fact2):
                state.numberFact = fact
                state.numberDate = fact2
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

            if let fact2 = store.numberDate {
                Text(fact2)
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
