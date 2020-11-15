//
//  UIViewToAutoLayout.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 14.11.2020.
//

import UIKit

// MARK: - AutoLayout
extension UIView {
    func addSubviewWithAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
    

