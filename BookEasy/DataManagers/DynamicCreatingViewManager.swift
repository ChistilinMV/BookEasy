//
//  DynamicCreatingViewManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class DynamicCreatingViewManager {
    
    // MARK: - Properties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static var shared = DynamicCreatingViewManager()
    
    // Constants for horizontal indents and distance between views
    private let horizontalPadding: CGFloat = 16
    private let labelSpacing: CGFloat = 8
    
    // MARK: - Init

    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension DynamicCreatingViewManager {
    
    // MARK: Label creation
    
    func configLabelsWithData(with peculiarities: [String], verticalStackView: UIStackView, customCell: UITableViewCell) {

        // Removing all current subviews in verticalStackView
        for arrangedSubview in verticalStackView.arrangedSubviews {
            verticalStackView.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
        
        // Creating the first horizontal StackView
        var horizontalStackView: UIStackView = createNewHorizontalStackView()
        verticalStackView.addArrangedSubview(horizontalStackView)
        
        // Determining the available width for views with labels
        var remainingWidth = customCell.frame.width - 2 * horizontalPadding
        
        // Iterate over each data element (assuming they are strings)
        for text in peculiarities {
            
            // Creating a new view and label
            let containerView = UIView()
            containerView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 252/255, alpha: 1)
            containerView.layer.cornerRadius = 5
            containerView.clipsToBounds = true
            
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
            label.textColor = UIColor(red: 130/255, green: 135/255, blue: 150/255, alpha: 1)
            
            containerView.addSubview(label)
            
            // Setting constraints for a label inside a view
            label.translatesAutoresizingMaskIntoConstraints = false
            let topConstraint = label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5)
            let bottomConstraint = label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
            let leadingConstraint = label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10)
            let trailingConstraint = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
            
            // Setting priorities for constraints
            topConstraint.priority = .defaultHigh
            
            // Activating constraints
            NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
            
            // Measuring text width
            let titleWidth = textWidth(text, font: label.font, height: 20)
            
            // Check, if the view does not fit, create a new horizontal StackView
            if remainingWidth - (titleWidth + labelSpacing) < 0 {
                horizontalStackView = createNewHorizontalStackView()
                verticalStackView.addArrangedSubview(horizontalStackView)
                remainingWidth = customCell.frame.width - 2 * horizontalPadding
            }
            
            // Reducing available width
            remainingWidth -= (titleWidth + labelSpacing)
            
            // Adding a view to a horizontal StackView
            horizontalStackView.addArrangedSubview(containerView)
        }
    }
    
    // Private method to create a new horizontal StackView
    private func createNewHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = labelSpacing
        return stackView
    }
    
    // Private method for measuring text width with specified limits
    private func textWidth(_ text: String, font: UIFont?, height: CGFloat) -> CGFloat {
        guard let font = font else { return 0 }
        return text.width(withConstrainedHeight: height, font: font)
    }
    
}
