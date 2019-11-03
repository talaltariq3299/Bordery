//
//  BorderColorExentesion.swift
//  Bordery
//
//  Created by Kevin Laminto on 3/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit

extension UIColor {
    // makes the colour a background for uiiimage
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

