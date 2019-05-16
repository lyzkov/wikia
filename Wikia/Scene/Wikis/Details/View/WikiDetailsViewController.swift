//
//  WikiDetailsViewController.swift
//  Wikia
//
//  Created by BOGU$ on 14/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class WikiDetailsViewController: UIViewController {

    @IBOutlet private weak var wikiTitle: UILabel!

    @IBOutlet private weak var wikiDescription: UILabel!

    @IBOutlet private weak var wikiImage: UIImageView!

    @IBOutlet private weak var openWebsiteButton: UIButton!

    @IBOutlet private var stats: [UILabel]!

    private let disposeBag = DisposeBag()

    private lazy var processor = DownsamplingImageProcessor(size: wikiImage.frame.size)

    let cyclone = WikiDetailsCyclone()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Details

        let details = cyclone.output[\.details]
            .compactMap { $0 }
            .share(replay: 1)

        details.map { $0.title }
            .bind(to: wikiTitle.rx.text)
            .disposed(by: disposeBag)

        details.map { $0.description }
            .bind(to: wikiDescription.rx.text)
            .disposed(by: disposeBag)

        details.map { $0.imageURL }
            .compactMap { $0 }
            .subscribe(onNext: { [unowned self] imageURL in
                self.wikiImage.kf.setImage(
                    with: imageURL,
                    options: [
                        .processor(self.processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(0.25)),
                        .cacheOriginalImage,
                    ]
                )
            })
            .disposed(by: disposeBag)

        // Stats

        details.map { $0.stats }
            .subscribe(onNext: { [unowned self] wikiStats in
                for item in wikiStats {
                    self.stats.item(item.tag)?.text = item.description
                }
            })
            .disposed(by: disposeBag)

        // Navigation

        details.compactMap { $0.websiteURL }
            .bind(
                to: openWebsiteButton.rx.tap(
                    segue: rx.segue(identifier: R.segue.wikiDetailsViewController.showWebsite.identifier)
                )
            ) { (url, destination: WikiWebsiteViewController) in
                destination.url.onNext(url)
            }
            .disposed(by: disposeBag)
    }

}

fileprivate extension Array where Element: UIView {

    func item(_ tag: Int) -> Element? {
        return first { view in
            view.tag == tag
        }
    }

}
