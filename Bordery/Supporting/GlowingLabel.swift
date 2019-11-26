//
//  GlowingLabel.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit
import QuartzCore

// from https://github.com/KrisYu/GlowLabel
@IBDesignable
class GlowingLabel: UILabel {

    @IBInspectable
    var blurColor :UIColor = UIColor(red: 104.0/255,green: 248.0/255,blue: 0/255,alpha: 0.7){
        didSet { setNeedsDisplay() }
    }

    @IBInspectable
    var glowSize :CGFloat = 25.0


    override func drawText(in rect: CGRect) {

        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setShadow(offset: CGSize(width: 0, height: 0)
                , blur: self.glowSize
                , color: self.blurColor.cgColor)

            ctx.setTextDrawingMode(.fillStroke)
        }

        super.drawText(in: rect)
    }

}
