//
//  Typography.swift
//  Bordery
//
//  Created by Kevin Laminto on 28/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit
import BonMot

struct Typography {
    
    // returns the style of a title text. (for display title of a large amount of text)
    static func titleLarge() -> StringStyle {
        let style = StringStyle(
            .lineHeightMultiple(1.4),
            .font( UIFont(name: "NewYorkMedium-Regular", size: 18)!)
        )
        
        return style
    }
    
    // returns the style of a body text. (for display large amount of text)
    static func bodyLarge() -> StringStyle {
        let style = StringStyle(
            .lineHeightMultiple(1.4),
            .font(UIFont.systemFont(ofSize: 13, weight: .light)),
            .tracking(.point(0.3))
        )
        
        return style
    }
    
    // returns the style of a sub-body text. (for display large amount of text)
    static func subbodyLarge() -> StringStyle {
        let style = StringStyle(
            .lineHeightMultiple(1.2),
            .font(UIFont.systemFont(ofSize: 11, weight: .light)),
            .tracking(.point(0.3))
        )
        
        return style
    }
    
    // returns the style of a body text. (for general and functions name)
    static func body() -> StringStyle {
        let style = StringStyle(
            .lineHeightMultiple(1.4),
            .font(UIFont.systemFont(ofSize: 12, weight: .regular)),
            .tracking(.point(0.3))
        )
        
        return style
    }
}
