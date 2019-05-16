//
//  WikiWebsiteViewController.swift
//  Wikia
//
//  Created by BOGU$ on 16/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

final class WikiWebsiteViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet private weak var webView: WKWebView!

    lazy var url = ReplaySubject<URL>.create(bufferSize: 1)

    lazy var output = state(from: url.map(Event.loadURL))

    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()

        webView.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output[\.url]
            .compactMap { $0 }
            .subscribe(onNext: { [unowned self] url in
                self.webView.load(URLRequest(url: url))
            })
            .disposed(by: disposeBag)

    }

}

// Another approach is to integrate cyclone with view controller

extension WikiWebsiteViewController: Cyclone {

    struct State: ReducibleState {

        enum Event: EventType {
            case loadURL(url: URL)
        }

        static var initial: State = .init(url: nil)

        let url: URL?

        static func reduce(state: State, _ event: Event) -> State {
            switch event {
            case .loadURL(let url):
                return .init(url: url)
            }
        }

    }

}
