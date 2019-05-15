//
//  Feed.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

protocol Paginable {
    associatedtype Item

    var items: [Item] { get }
    var index: UInt { get }
    var hasNext: Bool { get }
}

final class Pagination<Page: Paginable>: IteratorProtocol {

    private let factory: (UInt) -> Observable<Page>
    fileprivate var pages: [Page] = []

    init<Factored>(factory: @escaping (UInt) -> Factored)
        where Factored: ObservableConvertibleType, Factored.Element == Page {
        self.factory = { next in
            factory(next).asObservable()
        }
    }

    func next() -> Observable<[Page.Item]>? {
        let pagination = self
        guard let nextIndex = pages.nextIndex else {
            return nil
        }

        return factory(nextIndex)
            .do(onNext: { page in
                pagination.pages.append(page)
            })
            .map { page in
                page.items
            }
    }

}

final class Feed<Page: Paginable>: ObservableType {
    typealias Element = [Page.Item]

    private let pagination: Pagination<Page>
    private let trigger: Observable<Void>

    init<Trigger, Factored>(trigger: Trigger, factory: @escaping (UInt) -> Factored)
        where Trigger: ObservableConvertibleType, Factored: ObservableConvertibleType,
            Trigger.Element == Void, Factored.Element == Page {
        self.pagination = Pagination<Page>(factory: factory)
        self.trigger = trigger.asObservable()
    }

    func subscribe<Observer>(_ observer: Observer) -> Disposable
        where Observer: ObserverType, Element == Observer.Element {
        return items.subscribe(observer)
    }

    private var items: Observable<[Page.Item]> {
        guard let next = pagination.next() else {
            return .just(pagination.pages.items)
        }

        return next
            .flatMap { [unowned self] _ in
                Observable<[Page.Item]>.concat(
                    Observable.just(self.pagination.pages.items),
                    Observable.never().takeUntil(self.trigger),
                    self.items
                )
            }
    }

}

fileprivate extension Array where Element: Paginable {

    var items: [Element.Item] {
        return flatMap { page in
            page.items
        }
    }

    var nextIndex: UInt? {
        return hasNext ? (last?.index ?? 0) + 1 : nil
    }

    var hasNext: Bool {
        return last?.hasNext ?? true
    }

}
