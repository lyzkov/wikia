//
//  WikisListCyclone.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

final class WikisListCyclone: Cyclone {

    // Machine state (store + reducer), keep business logic here
    
    struct State: ReducibleState {

        enum Event: EventType {
            case load(wikis: [Wiki])
        }

        static let initial = State(wikis: [])

        let wikis: [Wiki]

        var overviews: [WikiOverview] {
            return wikis.map(WikiOverview.init)
        }

        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case let .load(wikis):
                return .init(wikis: wikis)
            }
        }
    }

    // Inputs

    lazy var trigger = PublishSubject<Void>()

    // Outputs

    lazy var output = state(from: wikis)

    // Dependencies
    // TODO: Dependency Injection

    private let pool = WikisPool()

    // Events

    private lazy var wikis = Feed(trigger: trigger, factory: pool.list).map(Event.load)

}
