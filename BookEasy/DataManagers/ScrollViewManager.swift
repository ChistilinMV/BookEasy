//
//  ScrollViewManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class ScrollViewManager: NSObject {
    
    // MARK: - Properties
    
    // Singleton to access the manager
    static let shared = ScrollViewManager()
    
    private weak var scrollView: UIScrollView?
    
    private weak var viewController: UIViewController?
    
    // MARK: - Init
    
    // Private initializer to prevent new instances of the class from being created
    private override init() {}
    
    deinit {
        // Remove the current object as an observer for all notifications to avoid memory leaks
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - Scroll view delegate

extension ScrollViewManager: UIScrollViewDelegate {
    
    // Method for setting the keyboard to hide when scrolling
    func setupToHideKeyboardOnScroll(scrollView: UIScrollView, viewController: UIViewController) {
        // Set up scrollView and viewController so that you can access them in other methods
        self.scrollView = scrollView
        self.viewController = viewController
        
        // Set the current object (ScrollViewManager) as a scrollView delegate
        scrollView.delegate = self
        
        // Adding observers for notifications about the appearance and hiding of the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // When we start dragging the contents of the scrollView, we stop editing to hide the keyboard
        viewController?.view.endEditing(true)
    }
    
    // Method called before the keyboard appears
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        // Retrieving information from the notification, including keyboard size
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        // Set the padding for the scrollView so that the keyboard does not overlap the content
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.height, right: 0.0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Method called before hiding the keyboard
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        // Set the scrollView to zero padding, returning it to its original state
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
}
