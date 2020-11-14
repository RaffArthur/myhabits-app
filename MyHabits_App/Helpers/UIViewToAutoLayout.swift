//
//  UIViewToAutoLayout.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 14.11.2020.
//

import UIKit

// MARK: - AutoLayout
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
