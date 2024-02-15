//
//  TextFieldManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class TextFieldManager: NSObject {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    
    // Placeholder size
    private let sizeSmallPlaceholder: CGFloat = 12
    private let sizeNormalPlaceHolder: CGFloat = 17
    
    // Text field height
    private let textFieldHeight: CGFloat = 52
    
    // Blending text from left edge
    private let leftPadding: CGFloat = 16
    
    // Small placeholder position
    private let placeholderPosotion: CGFloat = 10
    
    // Text position
    private let textPosition: CGFloat = -8
    
    // Setting the default placeholder position
    private let placeholderAdjustment: CGFloat = 1.0
    
    private var previousText: String?
    private let fontNameRegular = "SFProDisplay-Regular"
    private let phoneNumber = "Номер телефона"
    private let maskPhoneNumber = "+7 (***) ***-**-**"
    
    // Singleton class instance
    static var shared = TextFieldManager()
    
}

// MARK: - Text field delegate

extension TextFieldManager: UITextFieldDelegate {
    
    // UITextField delegate methods for placeholder animation
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let placeholderLabel = textField.viewWithTag(100) as? UILabel {
            UIView.animate(withDuration: 0.3) {
                placeholderLabel.font = UIFont(name: self.fontNameRegular, size: self.sizeSmallPlaceholder)
                placeholderLabel.frame.origin = CGPoint(x: self.leftPadding, y: self.placeholderPosotion)
            }
        }
        
        // Set a mask for entering a phone number if the input field is empty or nil
        if textField.placeholder == phoneNumber && (textField.text == nil || textField.text?.isEmpty == true) {
            textField.text = maskPhoneNumber
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let placeholderLabel = textField.viewWithTag(100) as? UILabel, textField.text?.isEmpty == true {
            // If the text field is empty after editing, return the placeholder to its original position with animation
            UIView.animate(withDuration: 0.3) {
                placeholderLabel.font = UIFont(name: self.fontNameRegular, size: self.sizeNormalPlaceHolder)
                placeholderLabel.frame.origin = CGPoint(x: self.leftPadding, y: (self.textFieldHeight - self.sizeNormalPlaceHolder) / 2)
            }
            // Removing text from a text field
            textField.backgroundColor = UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.15)
        } else {
            // If the field is not empty, return it to its old color
            textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 249/255, alpha: 1)
        }
        
        // Checking for correct email and changing color
        if textField.placeholder == "Почта" {
            if let email = textField.text, !isValidEmail(email) {
                // Email is incorrect - paint the field in the error color
                textField.backgroundColor = UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.15)
            } else {
                // Email is correct - set the text color to normal
                textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 249/255, alpha: 1)
            }
        }
        
        // Checking for completeness of phone number entry and changing color
        if textField.placeholder == phoneNumber {
            let phoneNumber = textField.text ?? ""
            
            // Checking if the phone number contains asterisks
            if phoneNumber.contains("*") {
                textField.backgroundColor = UIColor(red: 235/255, green: 87/255, blue: 87/255, alpha: 0.15)
            } else {
                textField.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 249/255, alpha: 1)
            }
        }
    }
    
    // Setting up text fields
    func textFiledsConfig(for textFields: [UITextField], radius: CGFloat) {
        for textField in textFields {
            
            // Add a clear button so that it is also visible in dark mode
            textField.clearButtonMode = .whileEditing
            if let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
                clearButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
                clearButton.tintColor = UIColor.gray
            }
            
            // Setting corner rounding for a text field
            textField.layer.cornerRadius = radius
            
            // Set the current object as a delegate for the text field
            textField.delegate = self
            
            // Set the text baseline offset
            textField.defaultTextAttributes.updateValue(textPosition, forKey: NSAttributedString.Key.baselineOffset)
            
            // Set the left margin for the text field
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            
            // Setting up and adding a placeholder to a text field
            let placeholderLabel = UILabel()
            placeholderLabel.text = textField.placeholder
            placeholderLabel.font = UIFont(name: self.fontNameRegular, size: sizeNormalPlaceHolder)
            placeholderLabel.textColor = UIColor(red: 169/255, green: 171/255, blue: 183/255, alpha: 1)
            placeholderLabel.frame.size = CGSize(width: textField.frame.width - 32, height: 17)
            placeholderLabel.frame.origin = CGPoint(x: leftPadding, y: ((textField.frame.height - sizeNormalPlaceHolder) / 2) - placeholderAdjustment)
            
            // Give the text field placeholder a transparent color to avoid overlap
            if let placeholder = textField.placeholder {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.clear
                ]
                textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
            
            // Adding a placeholder to a text field and setting a tag for later access to the placeholder
            placeholderLabel.tag = 100
            textField.addSubview(placeholderLabel)
            
            // Add a text change handler for the field with the "Phone number" placeholder
            if textField.placeholder == phoneNumber {
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            }
        }
    }
    
    // MARK: Block with phone number
    
    // The formattedNumber method formats the phone number according to the mask
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number // Get a clean phone number without formatting
        let mask = maskPhoneNumber // Set a mask for the phone number
        
        var result = "" // Resulting formatted number string
        var index = cleanPhoneNumber.startIndex // Index for clean number bypass
        
        // We go through the mask and replace the '*' symbols with the corresponding numbers from the clean number
        for maskCharacter in mask {
            if maskCharacter == "*" {
                if index < cleanPhoneNumber.endIndex {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(maskCharacter)
                }
            } else {
                result.append(maskCharacter)
            }
        }
        
        return result // Returning the formatted phone number according to the mask
    }
    
    // The textFieldDidChange method handles changes to the text field and formats the phone number entry
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // Filter the entered text, leaving only numbers
        var filteredText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // If the entered text begins with "7", remove this number
        if filteredText.starts(with: "7") {
            filteredText = String(filteredText.dropFirst())
        }
        
        // Limit text length to 10 characters
        if filteredText.count > 10 {
            filteredText = String(filteredText.prefix(10))
        }
        
        // Format filtered text using the formattedNumber method
        textField.text = formattedNumber(number: filteredText)
        
        // Finding a new cursor position taking into account the mask
        let newCursorPosition = findCursorPosition(input: textField.text ?? "", cursor: filteredText.count)
        
        // Setting a new cursor position
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: newCursorPosition) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        // If the formatted text is empty, set the cursor position to the beginning
        if filteredText.isEmpty, let newPosition = textField.position(from: textField.beginningOfDocument, offset: 4) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            return
        }
        
        previousText = textField.text
    }
    
    // The findCursorPosition function finds the cursor position in the text taking into account the mask
    func findCursorPosition(input: String, cursor: Int) -> Int {
        // Set a mask for the phone number
        let mask = maskPhoneNumber
        
        // Initialize the cursorPosition variable to track the cursor position
        var cursorPosition = 0
        
        // Initialize the inputIndex variable to track the position of the input text
        var inputIndex = 0
        
        // We go through each character in the mask
        for maskCharacter in mask {
            // Checking whether we have reached the specified cursor position
            if inputIndex >= cursor {
                break
            }
            
            // Increase the cursorPosition value to track the cursor position
            cursorPosition += 1
            
            // If the current character in the mask is a "*" (space) character, then increase inputIndex
            if maskCharacter == "*" {
                inputIndex += 1
            }
        }
        
        // Returning the found cursor position
        return cursorPosition
    }
    
    // MARK: Checking whether your email is filled out correctly
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // MARK: Hiding the keyboard
    
    // Method for setting up a tap gesture that will hide the keyboard
    func setupGestureToHideKeyboard(viewController: UIViewController) {
        self.viewController = viewController
        
        // Create a tap gesture object
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        // Adding a tap gesture to the view controller
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    // Method called when you tap on a view to hide the keyboard
    @objc
    func hideKeyboard() {
        // Close the keyboard to stop editing
        viewController?.view.endEditing(true)
    }
    
}
