//
//  FixedHeightAspectFitImageView.swift
//  Wikia
//
//  Created by BOGU$ on 16/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit

final class FixedHeightAspectFitImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        let frameSizeHeight = self.frame.size.height

        guard let image = self.image else {
            return CGSize(width: 1.0, height: frameSizeHeight)
        }

        let returnWidth = ceil(image.size.width * (frameSizeHeight / image.size.height))

        return CGSize(width: returnWidth, height: frameSizeHeight)
    }

}
