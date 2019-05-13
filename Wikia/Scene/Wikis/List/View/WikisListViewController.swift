//
//  WikisListViewController.swift
//  Wikia
//
//  Created by BOGU$ on 08/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class WikisListViewController: UICollectionViewController {

    @IBOutlet private weak var layout: UICollectionViewFlowLayout!

    private let disposeBag = DisposeBag()

    private let cyclone = WikisListCyclone()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.estimatedItemSize = layout.itemSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        collectionView.delegate = nil
        collectionView.dataSource = nil

        bind()
    }

    private func bind() {
        let wikiOverviews = cyclone.output[\.overviews].share()

        wikiOverviews
            .bind(to: collectionView.rx.items(
                cellIdentifier: R.reuseIdentifier.wikiOverviewCell.identifier,
                cellType: WikiOverviewCell.self
            )) { _, item, cell in
                cell.bind(item: item)
            }
            .disposed(by: disposeBag)

        collectionView.rx.prefetchItems
            .map { $0.map { $0.item } }
            .withLatestFrom(wikiOverviews) { indexes, overviews in
                indexes.map { overviews[$0] }
            }
            .map { $0.compactMap { $0.imageURL } }
            .subscribe(onNext: { urls in
                ImagePrefetcher(urls: urls).start()
            })
            .disposed(by: disposeBag)

        collectionView.rx.cancelPrefetchingForItems
            .map { $0.map { $0.item } }
            .withLatestFrom(wikiOverviews) { indexes, overviews in
                indexes.map { overviews[$0] }
            }
            .map { $0.compactMap { $0.imageURL } }
            .subscribe(onNext: { urls in
                ImagePrefetcher(urls: urls).stop()
            })
            .disposed(by: disposeBag)

        collectionView.rx.didReachBottom()
            .bind(to: cyclone.trigger)
            .disposed(by: disposeBag)
    }

}
