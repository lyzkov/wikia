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
        cyclone.wikiOverviews
            .bind(to: collectionView.rx.items(
                cellIdentifier: R.reuseIdentifier.wikiOverviewCell.identifier,
                cellType: WikiOverviewCell.self
            )) { _, item, cell in
                cell.title.text = item.title
                cell.image.image = item.image
            }
            .disposed(by: disposeBag)

        collectionView.rx.didReachBottom()
            .bind(to: cyclone.trigger)
            .disposed(by: disposeBag)
    }

}
