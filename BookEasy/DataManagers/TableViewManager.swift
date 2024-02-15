//
//  TableViewManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class TableViewManager {
    
    // MARK: - Propeties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static var shared = TableViewManager()
    
    // MARK: Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension TableViewManager {
    
    // So that when pulling the table down, the user sees a white background and not the table background
    func whiteBackgroundWhenPullingTable(view: UIView, tableView: UITableView) {
        view.frame = CGRect(x: 0, y: -300, width: tableView.bounds.width, height: 300)
        view.backgroundColor = .white
        tableView.addSubview(view)
    }
    
    // Method for adding custom table cell separator borders
    func addCustomBorderForTableCellSeparator(for views: [UIView]) {
        for view in views {
            
            // Set the border width and color for each cell separator
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 0.15).cgColor
            view.layer.backgroundColor = UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 0.15).cgColor
        }
    }
    
    // MARK: Cell appearance
    
    // Method for customizing cell appearance
    func setupViewAppearance(customCell: UITableViewCell, shouldApplyCornerRadius: Bool = true) {
        
        // Setting background colors
        customCell.backgroundColor = UIColor.clear
        customCell.contentView.backgroundColor = .white
        
        // Rounding corners for contentView
        if shouldApplyCornerRadius {
            UtilityManager.shared.cornerRadius(for: customCell.contentView, radius: 15)
        }
    }
    
    // MARK: Nested Table Controller
    
    // Method for initializing and configuring a nested table controller in a custom cell
    func setupNestedTableViewControllerInCell(for cell: Main2TableViewCell) {
        guard cell.nestedTableViewController == nil else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        cell.nestedTableViewController = storyboard.instantiateViewController(withIdentifier: "NestedTableViewController") as? NestedTableViewController
        
        guard let tableView = cell.nestedTableViewController?.tableView else { return }
        
        cell.containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cell.containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: cell.containerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: cell.containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: cell.containerView.trailingAnchor)
        ])
    }
    
    // Set additional bottom margin for tableView
    func additionalPadding(for number: CGFloat, tableView: UITableView, view: UIView) {
        let additionalPadding: CGFloat = number
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom + additionalPadding, right: 0)
    }
    
}
