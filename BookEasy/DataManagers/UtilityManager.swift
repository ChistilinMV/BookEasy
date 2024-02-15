//
//  UtilityManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class UtilityManager {
    
    // MARK: - Properties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static var shared = UtilityManager()
    
    // Container height for expanded view
    private let expandedViewHeight: CGFloat = 430.0
    private let collapsedViewHeight: CGFloat = 58.0
    
    // MARK: - Init
    
    private init() {}
    
}

// MARK: - Methods

extension UtilityManager {
    
    // Customizing the appearance of the navigation bar
    func setupNavigationBar(for viewController: UIViewController) {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        viewController.navigationController?.navigationBar.standardAppearance = appearance
        viewController.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        guard let font = UIFont(name: "SFProDisplay-Medium", size: 18) else { return }
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
    }
    
    func changeBackButtonTextAndColor(for viewController: UIViewController) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
    // Method to format minimum price with thousands separator added
    func formatMinimalPrice(_ minimalPrice: Int, withPrefix: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        if let formattedNumber = formatter.string(from: NSNumber(value: minimalPrice)) {
            if withPrefix {
                return "от \(formattedNumber) ₽"
            } else {
                return "\(formattedNumber) ₽"
            }
        } else {
            return "Цена не доступна"
        }
    }
    
    // Setting boundaries for bottomView
    func configureBordersForBottomView(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 232/255, green: 233/255, blue: 236/255, alpha: 1).cgColor
    }
    
    // Setting the rounding of corners of something
    func cornerRadius<T: UIView>(for element: T, radius: CGFloat) {
        element.layer.cornerRadius = radius
    }
    
    // Setting up a stack view with a hotel rating
    func hotelLevel(stackView stackViewWithStar: UIStackView) {
        stackViewWithStar.backgroundColor = UIColor(red: 1, green: 199/255, blue: 0/255, alpha: 0.2)
        stackViewWithStar.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackViewWithStar.isLayoutMarginsRelativeArrangement = true
        UtilityManager.shared.cornerRadius(for: stackViewWithStar, radius: 5)
    }
    
    // View resizing method
    func changeSizeforView(constraints: [NSLayoutConstraint], stackViews: [UIStackView], sender: UIButton, in view: UIView, withTag tag: Int, isCollapsible: Bool = true, shouldChangeImage: Bool = true) {
        guard let stackView = stackViews.first(where: { $0.tag == tag }) else {
            return
        }

        guard let constraint = constraints.first(where: { $0.identifier == "\(tag)" }) else {
            return
        }

        if constraint.constant == collapsedViewHeight {
            stackView.isHidden = false
            constraint.constant = expandedViewHeight
            if shouldChangeImage {
                sender.setImage(UIImage(named: "upArrow"), for: .normal)
            }
        } else if isCollapsible {
            stackView.isHidden = true
            constraint.constant = collapsedViewHeight
            if shouldChangeImage {
                sender.setImage(UIImage(named: "downArrow"), for: .normal)
            }
        }

        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }

    // Generating a 6-digit random number
    private func generateRandomSixDigitNumber() -> Int {
        let randomNumber = Int.random(in: 100000..<1000000)
        return randomNumber
    }
    
    // Order confirmation text
    func orderConfirmation() -> String {
        return "Подтверждение заказа №\(generateRandomSixDigitNumber()) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от отеля, вам на почту придет уведомление."
    }
    
    // Alert controller
    func showAlert(from viewController: UIViewController?, title: String, message: String) {
            guard let viewController = viewController else {
                return // If nil is passed, we simply exit the method
            }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.overrideUserInterfaceStyle = .light // Setting a light style
            let buttonOK = UIAlertAction(title: "OK", style: .default)
            alert.addAction(buttonOK)
            viewController.present(alert, animated: true)
        }
    
}
