//
//  File.swift
//
//
//  Created by Lova on 2024/5/5.
//

import ComposableArchitecture
import Foundation


struct NumberFactClient {
    var trivia: (Int) async throws -> String

    var date: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = NumberFactClient(
        trivia: { number in
            let url = URL(string: "http://numbersapi.com/\(number)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(decoding: data, as: UTF8.self)
        },
        date: { number in
            let url = URL(string: "http://numbersapi.com/\(number)/4/date")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension NumberFactClient: TestDependencyKey {
    static let testValue = NumberFactClient(
        trivia: { _ in
            "hihihihihi"
        },
        date: { _ in
            "dateeee"
        }
    )
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
