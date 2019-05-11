//
//  WikiasListCyclone.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import RxSwift

private let data = ["In computing, reactive programming is a programming paradigm oriented around data flows and the propagation of change. This means that it should be possible to express static or dynamic data flows with ease in the programming languages used, and that the underlying execution model will automatically propagate changes through the data flow"]

final class WikiasListCyclone: Cyclone {
    struct State: ReducibleState {
        enum Event: EventType {
            case load(data: [String])
        }

        static let initial = State(wikias: [])

        let wikias: [WikiaOverview]

        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case .load(let data):
                return .init(wikias: data.map { WikiaOverview(title: $0, image: nil) })
            }
        }
    }

    lazy var load = Observable.just(data).asAction(Event.load)

    lazy var output = state(from: load)

}
