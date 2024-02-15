//
//  UIViewController+extension.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

// Extension for UIViewController to add hideKeyboard method
extension UIViewController {
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}
