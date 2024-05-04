import ComposableArchitecture
@testable import Features
import XCTest

@MainActor
final class FeaturesTests: XCTestCase, Sendable {
    func testExample() async throws {
        let store = TestStore(
            initialState: AppFeature.State(),
            reducer: {
                AppFeature()
            }
        )

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }

        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }

        ///
        await store.send(.numberFactButtonTapped)

        await store.receive(\.numberFactResponse) {
            $0.numberFact = "hihihihihi"
        }
    }
}
