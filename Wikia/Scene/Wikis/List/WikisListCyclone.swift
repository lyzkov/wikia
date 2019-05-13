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
            case load(wikis: [Wiki])
        }

        static let initial = State(wikis: [])

        let wikis: [Wiki]

        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case .load(let wikis):
                return .init(wikis: wikis)
            }
        }
    }

    let pool = WikisPool()

    lazy var trigger = PublishSubject<Void>()

    lazy var load = Feed(trigger: trigger, factory: pool.list).map(Event.load)

    lazy var output = state(from: load)

    lazy var wikiOverviews = output[\.wikis].map { $0.map(WikiOverview.init) }

}
