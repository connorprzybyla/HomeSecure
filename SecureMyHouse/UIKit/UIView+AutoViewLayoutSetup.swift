//
//  UIView+AutoViewLayoutSetup.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Foundation
import UIKit

extension UIView {
    func setConstraints(equalTo parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
