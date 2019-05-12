//
//  WikisListCyclone.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

final class WikisListCyclone: Cyclone {
    
    struct State: ReducibleState {
        enum Event: EventType {
            case load(data: WikisList)
        }

        static let initial = State(wikis: [])

        let wikis: [WikiOverview]

        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case .load(let data):
                return .init(wikis: data.items.map { WikiOverview(from: $0) })
            }
        }
    }

    let pool = WikisPool()

    lazy var load = pool.list().asAction(Event.load)

    lazy var output = state(from: load)

}
