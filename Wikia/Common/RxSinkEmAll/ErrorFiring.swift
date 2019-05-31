//
//  ErrorFiring.swift
//  Wikia
//
//  Created by BOGU$ on 29/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import RxSwift

enum Fire {
    case hit(Error) // pass error
    case sink // complete
    case miss // retry
}

protocol ErrorFiring: class {
    associatedtype Error

    func fire(error: Self.Error, complete: ((Fire) -> Void)?)
}

extension ObservableConvertibleType {

    func fireError<Error>(handler: @escaping (Error) -> Single<Fire>, retryLimit: Int = 1)
        -> Observable<Element> {
        return asObservable()
            .retryWhen { errors in
                errors
                    .compactMap { error in
                        error as? Error
                    }
                    .flatMap { error in
                        handler(error)
                    }
                    .flatMap { fire -> Observable<Void> in
                        switch fire {
                        case .miss:
                            return .just(())
                        case .hit(let error):
                            return .error(error)
                        case .sink:
                            return .error(SinkError.sink)
                        }
                    }
                    .take(retryLimit)
            }
            .catchError { error in
                guard case SinkError.sink = error else {
                    return .error(error)
                }

                return .empty()
            }
    }

    func fireError<Handler, Error>(handler: Handler, retryLimit: Int = 1)
        -> Observable<Element> where Handler: ErrorFiring, Error == Handler.Error {
            return fireError(handler: handler.fire, retryLimit: retryLimit)
    }

}

fileprivate enum SinkError: Error {
    case sink
}

fileprivate extension ErrorFiring {

    func fire(error: Self.Error) -> Single<Fire> {
        return .create { [weak self] observer in
            self?.fire(error: error) { fire in
                observer(.success(fire))
            }

            return Disposables.create()
        }
    }

}
