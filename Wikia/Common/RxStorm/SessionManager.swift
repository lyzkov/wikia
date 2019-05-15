//
//  SessionManager.swift
//  Wikia
//
//  Created by BOGU$ on 11/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

extension Reactive where Base: SessionManager {

    func data<E: Endpoint>(from endpoint: E) -> Single<Data> {
        let base = E.api.base
        
        return RxAlamofire.data(
            endpoint.method,
            base.url + endpoint.path,
            parameters: base.parameters + endpoint.parameters,
            encoding: endpoint.encoding,
            headers: base.headers + endpoint.headers
        ).asSingle()
    }

    func decodedData<E: Endpoint & Resource>(from endpoint: E) -> Single<E.Result> {
        return data(from: endpoint).decode().asSingle()
    }

    func decodedData<E: Endpoint>(from endpoint: E) -> Completable {
        return data(from: endpoint).asCompletable()
    }

    func data(from request: URLRequestConvertible) -> Single<Data> {
        return self.request(urlRequest: request).data().asSingle()
    }

    func decodedData<Model: Decodable>(from request: URLRequestConvertible) -> Single<Model> {
        return data(from: request).decode().asSingle()
    }

}
