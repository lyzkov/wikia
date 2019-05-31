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

    let cyclone = WikisListCyclone()

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

        // Configure cell

        wikiOverviews
            .bind(to: collectionView.rx.items(
                cellIdentifier: R.reuseIdentifier.wikiOverviewCell.identifier,
                cellType: WikiOverviewCell.self
            )) { _, item, cell in
                cell.bind(item: item)
            }
            .disposed(by: disposeBag)

        // Images prefetching

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

        // Loading next batches

        collectionView.rx.didReachBottom()
            .bind(to: cyclone.trigger)
            .disposed(by: disposeBag)

        // Navigation

        // TODO: add select item event to cyclone?
        // TODO: integrate with reactive coordinator pattern?
        cyclone.output[\.wikis]
            .bind(to:
                collectionView.rx.selectedItem(
                    segue: rx.segue(identifier: R.segue.wikisListViewController.showWikiDetails.identifier)
                )
            ) { (wiki: Wiki, destination: WikiDetailsViewController) in
                destination.cyclone.wiki.onNext(wiki)
            }
            .disposed(by: disposeBag)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Error

        cyclone.output
            .fireError(handler: self, retryLimit: 3)
            .subscribe()
            .disposed(by: disposeBag)
    }

}

extension UIViewController: ErrorFiring {
    typealias Error = Swift.Error
}

extension ErrorFiring where Self: UIViewController {

    func fire(error: UIViewController.Error, complete: ((Fire) -> Void)?) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Retry", style: .cancel) { _ in
                complete?(.miss)
            }
        )
        alert.addAction(
            UIAlertAction(title: "Close", style: .destructive) { _ in
                complete?(.sink)
            }
        )

        self.present(alert, animated: true)
    }

}
