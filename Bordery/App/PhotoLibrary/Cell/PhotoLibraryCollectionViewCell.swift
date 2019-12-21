//
//  PhotoLibraryCollectionViewCell.swift
//  Bordery
//
//  Created by Kevin Laminto on 1/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit

class PhotoLibraryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var representedAssetIdentifier: String!
    
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
