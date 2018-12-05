//
// Created by Marijn Schilling on 05/12/2018.
// Copyright (c) 2018 Marijn Schilling. All rights reserved.
//

import UIKit

class MovieCatalogCell: UICollectionViewCell {
    static let identifier = "MovieCatalogCellIdentifier"

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
