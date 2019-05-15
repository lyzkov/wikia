//
//  UIViewController+RxSegue.swift
//  Wikia
//
//  Created by BOGU$ on 15/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias SegueObservable<Sender> = Observable<(UIStoryboardSegue, Sender)>

extension Reactive where Base: UIViewController {

    func segue<Sender>(identifier: String) -> SegueObservable<Sender> {
        return methodInvoked(#selector(Base.prepare(for:sender:)))
            .compactMap { args in
                guard let segue = (args.first { ($0 as? UIStoryboardSegue)?.identifier == identifier }
                    as? UIStoryboardSegue), let sender = args.last as? Sender else {
                        return nil
                }

                return (segue, sender)
        }
    }

}

extension Reactive where Base: UICollectionView {

    func selectedItem<Item, Source: ObservableType>(segue: SegueObservable<UICollectionViewCell>)
        -> (_ source: Source)
        -> (_ handler: @escaping (Item, UIStoryboardSegue) -> Void)
        -> Disposable where Source.Element == [Item] {
            return { source in
                return { handler in
                    segue
                        .withLatestFrom(source) { ($0.0, $0.1, $1) }
                        .compactMap { segue, cell, items in
                            guard let indexPath = self.base.indexPath(for: cell) else {
                                return nil
                            }

                            return (items[indexPath.item], segue)
                        }
                        .subscribe(onNext: { item, segue in
                            handler(item, segue)
                        })
                }
            }
    }

    func selectedItem<Item, Destination: UIViewController, Source: ObservableType>
        (segue: SegueObservable<UICollectionViewCell>, destinationType: Destination.Type = Destination.self)
        -> (_ source: Source)
        -> (_ handler: @escaping (Item, Destination) -> Void)
        -> Disposable where Source.Element == [Item] {
            return { source in
                return { handler in
                    segue
                        .withLatestFrom(source) { ($0.0, $0.1, $1) }
                        .compactMap { segue, cell, items in
                            guard let indexPath = self.base.indexPath(for: cell),
                                let destination = segue.destination as? Destination else {
                                return nil
                            }

                            return (items[indexPath.item], destination)
                        }
                        .subscribe(onNext: { item, destination in
                            handler(item, destination)
                        })
                }
            }
    }

}
