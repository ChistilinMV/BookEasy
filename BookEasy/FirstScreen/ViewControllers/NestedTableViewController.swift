//
//  NestedTableViewController.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

// Nested table controller to display hotel booking details
class NestedTableViewController: UITableViewController {
    
    // MARK: - IB Outlets
    
    // Collection of custom separators for table cells
    @IBOutlet var customSeparatorForTableCell: [UIView]!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding custom borders to table cell separators
        TableViewManager.shared.addCustomBorderForTableCellSeparator(for: customSeparatorForTableCell)
    }
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // We output a message to the log when clicking on a cell
        Logger.log("The button was pressed, but has not yet been implemented")
        
        // Animating the change in the background color of a cell when clicked
        AnimationManager.shared.animateCellWhenSelected(indexPath: indexPath, tableView: tableView)
    }
    
}
