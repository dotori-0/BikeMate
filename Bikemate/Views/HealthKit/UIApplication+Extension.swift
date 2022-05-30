//
//  UIApplication+Extension.swift
//  Bikemate
//
//

import UIKit

extension UIApplication {
    var isLandscape: Bool {
        return windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
}
