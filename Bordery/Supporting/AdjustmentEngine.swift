//
//  AdjustmentEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 4/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

class AdjustmentEngine {
    var borderColor: UIImage = UIImage()
    var image: UIImage = UIImage()
    var imgSizeMultiplier: CGFloat = 0.10
    
    static let adjusmentName:[String] = ["Size", "Colour"]
    
    
    // MARK: - Blend image function
    func blendImages(backgroundImg: UIImage,foregroundImg: UIImage) -> Data? {
        // size variable
//        let topImageSize = 306 - (306*0.05)
//        let contentSize = 306 - (306 * 0)
        // this will be the background size. For this, set to the size of the foreground image since we want
        // to achieve "film" like border.
        let contentSizeH = foregroundImg.size.height
        let contentSizeW = foregroundImg.size.width
        
        // the magic. how the image will scale in the view.
        let topImageH = foregroundImg.size.height - (foregroundImg.size.height * imgSizeMultiplier)
        let topImageW = foregroundImg.size.width - (foregroundImg.size.width * imgSizeMultiplier)
        
        let bottomImage = backgroundImg
        let topImage = foregroundImg

        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width : contentSizeW, height: contentSizeH))
        let imgView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: topImageW, height: topImageH))
        
        // - Set Content mode to what you desire
        imgView.contentMode = .scaleAspectFill
        imgView2.contentMode = .scaleAspectFit

        // - Set Images
        imgView.image = bottomImage
        imgView2.image = topImage
        
        imgView2.center = imgView.center

        // - Create UIView
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: contentSizeW, height: contentSizeH))
        contentView.addSubview(imgView)
        contentView.addSubview(imgView2)

        // - Set Size
        let size = CGSize(width: contentSizeW, height: contentSizeH)

        // - Where the magic happens
        UIGraphicsBeginImageContextWithOptions(size, true, 0)

        contentView.drawHierarchy(in: contentView.bounds, afterScreenUpdates: true)

        guard let i = UIGraphicsGetImageFromCurrentImageContext(),
            let data = i.jpegData(compressionQuality: 1.0)
            else {return nil}

        UIGraphicsEndImageContext()

        return data
    }
}
