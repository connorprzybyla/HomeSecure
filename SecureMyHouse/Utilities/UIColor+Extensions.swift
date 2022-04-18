//
//  UIColor+Extensions.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/12/22.
//

import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 5, height: 5)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
