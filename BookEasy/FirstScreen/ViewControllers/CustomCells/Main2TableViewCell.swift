//
//  Main2TableViewCell.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class Main2TableViewCell: UITableViewCell {
    
    // MARK: - Propeties
    
    // A reference to the nested table controller that will be used in this cell
    var nestedTableViewController: NestedTableViewController?
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var hotelDescription: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var verticalStackView: UIStackView!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initial UI setup
        setupUI()
    }
    
}

// MARK: - Methods

extension Main2TableViewCell {
    
    // MARK: Configuring the cell
    
    func configCell(dataModel: Hotel, indexPath: IndexPath) {
        DynamicCreatingViewManager.shared.configLabelsWithData(with: dataModel.aboutTheHotel.peculiarities, verticalStackView: verticalStackView, customCell: self)
        
        hotelDescription.text = dataModel.aboutTheHotel.description
    }
    
    // Method for initial UI setup
    private func setupUI() {
        UIManager.shared.setupNestedTableViewControllerInCell(for: self)
        UIManager.shared.setupViewAppearance(customCell: self)
    }
    
}
