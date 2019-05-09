//
//  WikiaListViewController.swift
//  Wikia
//
//  Created by BOGU$ on 08/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let data = ["In computing, reactive programming is a programming paradigm oriented around data flows and the propagation of change. This means that it should be possible to express static or dynamic data flows with ease in the programming languages used, and that the underlying execution model will automatically propagate changes through the data flow"]

final class WikiaListViewController: UICollectionViewController {

    @IBOutlet private weak var layout: UICollectionViewFlowLayout!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        layout.estimatedItemSize = layout.itemSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        bind()
    }

    private func bind() {
        Observable.just(data)
            .bind(to: collectionView.rx.items(cellIdentifier: "wikiaCell", cellType: WikiaViewCell.self)) { _, item, cell in
                cell.title.text = item
            }
            .disposed(by: disposeBag)
    }

}
