//
//  UIScrollView+Feed.swift
//  Wikia
//
//  Created by BOGU$ on 12/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {

    func didReachBottom(with offset: CGFloat = 20.0) -> ControlEvent<Void> {
        let source = contentOffset
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .map { [base] point in
                point.y + base.frame.size.height + offset > base.contentSize.height
            }
            .flatMap { isNearBottom -> Observable<Void> in
                isNearBottom ? .just(()) : .never()
            }

        return ControlEvent(events: source)
    }

}
