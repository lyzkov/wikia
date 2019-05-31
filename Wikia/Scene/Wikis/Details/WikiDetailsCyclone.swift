//
//  WikiDetailsCyclone.swift
//  Wikia
//
//  Created by BOGU$ on 14/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

final class WikiDetailsCyclone: Cyclone {

    // Machine state (store + reducer)

    struct State: ReducibleState {
        enum Event: EventType {
            case load(wiki: Wiki)
        }

        static let initial = State(wiki: nil)

        private let wiki: Wiki?

        var details: WikiDetails? {
            return wiki.flatMap(WikiDetails.init)
        }


        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case let .load(wiki):
                return .init(wiki: wiki)
            }
        }
    }

    // Inputs

    lazy var wiki = ReplaySubject<Wiki>.create(bufferSize: 1)

    // Outputs

    lazy var output = state(from: wiki.map(Event.load))

    // Dependencies

    // Events

}
