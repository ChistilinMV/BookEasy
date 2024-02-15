//
//  AnimationManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class AnimationManager {
    
    // MARK: - Propeties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static var shared = AnimationManager()
    
    // MARK: Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension AnimationManager {
    
    // Animating the change in the background color of a cell when clicked
    func animateCellWhenSelected(indexPath: IndexPath, tableView: UITableView) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.1, animations: {
            cell?.contentView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 248/255, alpha: 1)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                cell?.contentView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 252/255, alpha: 1)
            })
        }
    }
    
}
