import ComposableArchitecture
@testable import Features
import XCTest

final class FeaturesTests: XCTestCase {
    @MainActor
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
        await store.send(.numberFactButtonTapped) {
            $0.numberFact = "loading..."
            $0.numberDate = "loading..."
        }

        await store.receive(\.numberFactResponse) {
            $0.numberFact = "hihihihihi"
            $0.numberDate = "dateeee"
        }
    }
}
