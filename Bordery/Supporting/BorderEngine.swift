//
//  BorderEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 4/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

/**
 Struct class responsible with creating the border, and resizing the image.
 */
struct BorderEngine {
    var imgSizeMultiplier: CGFloat = 0.0
    let adjustmentName:[String] = ["Size", "Colour", "Ratio"]
    var sliderCurrentValue: Float = 0.0
    var sliderCurrentValueRatio: String = "0.0"
    var imgSizeMultiplierCurrent: CGFloat = 1.0
    
    
    // MARK: - Blend image function
    /**
     Creates the final image blended
     - Parameter:
        - backgroundImg: the border
        - foregroundImg: the image
     - Returns: JPEG data.
     */
    func blendImages(backgroundImg: UIImage,foregroundImg: UIImage) -> Data? {
        // size variable
        let contentSizeH = backgroundImg.size.height
        let contentSizeW = backgroundImg.size.width
        
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
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        contentView.drawHierarchy(in: contentView.bounds, afterScreenUpdates: true)
        
        guard let i = UIGraphicsGetImageFromCurrentImageContext(),
            let data = i.jpegData(compressionQuality: 1.0)
            else {return nil}
        
        UIGraphicsEndImageContext()
        
        return data
    }
    
    /**
     Creates the border of the image.
     - Parameter:
        - borderColor: The color of the border
        - foregroundImage: The image (needed for the size)
     - Returns: Rendered border image
     */
    func createBorderColor(borderColor: UIImage, foregroundImage: UIImage) -> UIImage {
        let contentSizeH = foregroundImage.size.height
        let contentSizeW = foregroundImage.size.width
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentSizeW, height: contentSizeH))
        
        imgView.contentMode = .scaleAspectFill
        imgView.image = borderColor
        
        let size = CGSize(width: contentSizeW, height: contentSizeH)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        imgView.drawHierarchy(in: imgView.bounds, afterScreenUpdates: true)
        
        guard let i = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
        
        return i
        
    }
    
    /**
     Creates the foreground image.
     - Parameter:
        - foregroundImage: The image that will be resized
     - Returns: The rendered image.
     */
    func createRenderImage(foregroundImage: UIImage, backgroundImageFrame: CGRect) -> UIImage {
        let imageSizeH = backgroundImageFrame.size.height
        let imageSizeW = backgroundImageFrame.size.width
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSizeW, height: imageSizeH))
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = foregroundImage
        
        let size = CGSize(width: imageSizeW, height: imageSizeH)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        imgView.drawHierarchy(in: imgView.bounds, afterScreenUpdates: true)
        
        guard let i = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
        
        return i
    }
    
    /**
     Creates the foreground image in square format.
     - Parameter:
        - foregroundImage: The image that will be resized
        - backgroundImageFrame: The frame of the background imagea
     - Returns: The rendered image.
     */
    func createRenderImageSquare(foregroundImage: UIImage, backgroundImageFrame: CGRect) -> UIImage {
        let imageSizeH = backgroundImageFrame.size.height
        let imageSizeW = backgroundImageFrame.size.height
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSizeW, height: imageSizeH))
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = foregroundImage
        
        let size = CGSize(width: imageSizeW, height: imageSizeH)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        imgView.drawHierarchy(in: imgView.bounds, afterScreenUpdates: true)
        
        guard let i = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
        
        return i
    }
    
//    /**
//     Creates the foreground image in portrait format.
//     - Parameter:
//        - foregroundImage: The image that will be resized
//        - backgroundImageFrame: The frame of the background imagea
//     - Returns: The rendered image.
//     */
//    func createRenderImagePortrait(foregroundImage: UIImage, backgroundImageFrame: CGRect) -> UIImage {
//        let imageSizeH = foregroundImage.size.height * 9
//        let imageSizeW = backgroundImageFrame.size.width
//
//        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSizeW, height: imageSizeH))
//
//        imgView.contentMode = .scaleAspectFit
//        imgView.image = foregroundImage
//
//        let size = CGSize(width: imageSizeW, height: imageSizeH)
//
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        imgView.drawHierarchy(in: imgView.bounds, afterScreenUpdates: true)
//
//        guard let i = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
//
//        return i
//    }
    
    
    
}
