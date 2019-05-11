//
//  State.swift
//  Wikia
//
//  Created by BOGU$ on 09/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Foundation
import RxSwift

protocol ReducibleState {
    associatedtype Event: EventType

    static var initial: Self { get }
    static func reduce(state: Self, _ event: Event) -> Self
}

extension ObservableConvertibleType where Element: ReducibleState {

    subscript<Value>(_ keyPath: KeyPath<Element, Value>) -> Observable<Value> {
        return asObservable().map { $0[keyPath: keyPath] }
    }

}
