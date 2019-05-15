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

    private let disposeBag = DisposeBag()

    private lazy var processor = DownsamplingImageProcessor(size: wikiImage.frame.size)

    let cyclone = WikiDetailsCyclone()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                        .cacheOriginalImage
                    ]
                )
            })
            .disposed(by: disposeBag)
    }

}
