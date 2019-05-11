//
//  Event.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol EventType { }

typealias EventAction<Event: EventType> = Action<Void, Event>

extension ObservableConvertibleType where Element: EventType {

    func asAction() -> EventAction<Element> {
        let observable = asObservable()

        return Action {
            observable
        }
    }

}

extension ObservableConvertibleType {

    func asAction<Event: EventType>(_ eventMap: @escaping (Element) -> Event) -> EventAction<Event> {
        return asObservable().map(eventMap).asAction()
    }

}
