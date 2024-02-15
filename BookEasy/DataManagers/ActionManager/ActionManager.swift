//
//  ActionManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class ActionManager {
    
    // MARK: - Properties
    
    static let shared = ActionManager()
    
    // MARK: - Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension ActionManager {
    
    // Method for adding a new tourist
    func addNewCustomer(currentViewIndex: inout Int, mainStackView: UIStackView, controller: UIViewController) {
        
        if currentViewIndex < 12 {
            
            // Making the view with the current index visible
            mainStackView.arrangedSubviews[currentViewIndex].isHidden = false
            
            currentViewIndex += 1
            // Increase the index by 1 for the next call
            
        } else {
            UtilityManager.shared.showAlert(from: controller, title: "Достигнут максимум туристов", message: "Вы добавили максимальное возможное колиичество туристов")
        }
    }
    
    // MARK: Block for the pay button
    
    // Method for folding and unfolding a section
    func toggleSectionVisibility(sender: UIButton, constraints: [NSLayoutConstraint], stackViews: [UIStackView], in view: UIView, withTag tagOffset: Int) {
        let newTag = sender.tag + tagOffset
        
        if (1...9).contains(sender.tag) {
            UtilityManager.shared.changeSizeforView(constraints: constraints, stackViews: stackViews, sender: sender, in: view, withTag: newTag)
        }
    }
    
    // Function to check if text fields are empty
    func checkTextFields(_ textFields: [UITextField], mainStackView: UIStackView) -> Bool {
        var hasEmptyField = false
        for textField in textFields {
            guard let parentView = textField.superview else { continue }
            // Checking whether the parent view of a given text field is visible
            if !isViewHidden(parentView, mainStackView: mainStackView),
               textField.text?.isEmpty ?? true {
                hasEmptyField = true
                textField.backgroundColor = UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.15)
            }
        }
        return hasEmptyField
    }
    
    // Function for processing empty fields and collapsing/expanding the corresponding views
    func handleUnfilledFields(uiContext: UIContext, tagOffset: Int) {
        for (index, view) in uiContext.views.enumerated() where !isViewHidden(view, mainStackView: uiContext.mainStackView) {
            let newTag = index + tagOffset
            guard let firstButton = uiContext.buttonsUpDownPlus.first else { fatalError("buttonsUpDownPlus is nil") }
            UtilityManager.shared.changeSizeforView(
                constraints: uiContext.viewConstraints,
                stackViews: uiContext.stacksInViews,
                sender: firstButton,
                in: uiContext.mainStackView,
                withTag: newTag, isCollapsible: false,
                shouldChangeImage: false
            )
        }
    }
    
    // Basic payment button method
    func payButtonAction(uiContext: UIContext, actionContext: ActionContext) {
        // Set tag offset for buttons
        let tagOffset = 21
        // Checking if there are empty input fields
        let hasEmptyField = checkTextFields(uiContext.textFields, mainStackView: uiContext.mainStackView)
        // If there are empty fields
        if hasEmptyField {
            // Showing a warning to the user
            UtilityManager.shared.showAlert(from: actionContext.controller, title: "Не все поля заполнены", message: "Или заполнены не корректно. Проверьте все поля помеченные красным")
            // Processing views where fields are not filled in
            handleUnfilledFields(uiContext: uiContext, tagOffset: tagOffset)
        } else {
            // If all fields are filled in, change the text and color of the "Back" button
            UtilityManager.shared.changeBackButtonTextAndColor(for: actionContext.controller)
            // Move to the next screen
            actionContext.performSegue()
        }
        
        // Scroll the ScrollView to the bottom edge (when views with empty fields open
        let bottomOffset = CGPoint(x: 0, y: uiContext.scrollView.contentSize.height - uiContext.scrollView.bounds.size.height + 33)
        uiContext.scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    private func isViewHidden(_ view: UIView?, mainStackView: UIStackView) -> Bool {
        guard let view = view else { return false }
        
        // We go through the superview until we reach the desired view
        var currentSuperview = view.superview
        while let superview = currentSuperview {
            if superview == mainStackView {
                break
            }
            if superview.isHidden {
                return true
            }
            currentSuperview = superview.superview
        }
        
        return false
    }
    
}
