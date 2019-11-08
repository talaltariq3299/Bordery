//
//  UIColorExtension+.swift
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

extension UIFont {

    enum Font: String {
        case SFUIText = "SFUIText"
        case SFUIDisplay = "SFUIDisplay"
    }

    private static func name(of weight: UIFont.Weight) -> String? {
        switch weight {
            case .ultraLight: return "UltraLight"
            case .thin: return "Thin"
            case .light: return "Light"
            case .regular: return nil
            case .medium: return "Medium"
            case .semibold: return "Semibold"
            case .bold: return "Bold"
            case .heavy: return "Heavy"
            case .black: return "Black"
            default: return nil
        }
    }

    convenience init?(font: Font, weight: UIFont.Weight, size: CGFloat) {
        var fontName = ".\(font.rawValue)"
        if let weightName = UIFont.name(of: weight) { fontName += "-\(weightName)" }
        self.init(name: fontName, size: size)
    }
}

