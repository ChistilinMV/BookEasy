//
//  UIManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import Foundation
import UIKit

class UIManager {
    
    // MARK: - Propertis
    
    // Singleton to access the manager
    static let shared = UIManager()
    
    // MARK: - Init
    
    // Private initializer to prevent new instances of the class from being created
    private init() {}
    
}

// MARK: - Methods

extension UIManager {
    
    // MARK: - First screen
    
    func setupFirstScreenUI(for screen: FirstScreenUISettings) {
        // Setting delegates to control table behavior
        screen.tableView.delegate = screen.viewController as? UITableViewDelegate
        screen.tableView.dataSource = screen.viewController as? UITableViewDataSource
        
        // Setting the rounding of a button
        UtilityManager.shared.cornerRadius(for: screen.blueButton, radius: 15)
        
        // Setting the Bottom View Borders
        UtilityManager.shared.configureBordersForBottomView(view: screen.bottomViewWithButton)
        
        // Customizing the Navigation Bar
        UtilityManager.shared.setupNavigationBar(for: screen.viewController)
        
        // Registering XIB for table cells
        screen.tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        screen.tableView.register(UINib(nibName: "Main2TableViewCell", bundle: nil), forCellReuseIdentifier: "MainSecondCell")
        
        // Querying data from a remote server for a data model
        NetworkManager.shared.getDataFromRemoteServer(urlString: screen.url, from: screen.viewController, tableView: screen.tableView) { hotelData in
            screen.completion(hotelData)
        }
        
        // So that when pulling the table down, the user sees a white background and not the table background
        TableViewManager.shared.whiteBackgroundWhenPullingTable(view: screen.whiteView, tableView: screen.tableView)
    }
    
    // MARK: First custom cell
    
    // Method for customizing cell appearance
    func setupFirstCustomCellForFirstScreen(customCell: MainTableViewCell, shouldApplyCornerRadius: Bool) {
        TableViewManager.shared.setupViewAppearance(customCell: customCell, shouldApplyCornerRadius: shouldApplyCornerRadius)
    }
    
    // Method to configure stackView
    func setupCustomCellStackView(stackView: UIStackView) {
        UtilityManager.shared.hotelLevel(stackView: stackView)
    }
    
    // Method for setting the rounding of corners viewWithPagination
    func setupViewWithPaginationCornerRadius(for view: UIView) {
        UtilityManager.shared.cornerRadius(for: view, radius: 5)
    }
    
    // Method for setting collectionView corner rounding
    func setupCollectionViewCornerRadius(for view: UIView) {
        UtilityManager.shared.cornerRadius(for: view, radius: 15)
    }
    
    // Method to register XIB for collectionView
    func registerCustomCellNibs(collectionView: UICollectionView) {
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "СollectionViewCell")
    }
    
    // Method for setting the collectionView background
    func setupCustomCellCollectionViewBackgroundColor(collectionView: UICollectionView, color: UIColor) {
        collectionView.backgroundColor = color
    }
    
    // Method for customizing the slider
    func setupSliderForCustomCell(cell: MainTableViewCell, imageUrls: [String]) {
        SliderManager.shared.delegate = cell
        SliderManager.shared.imageUrls = imageUrls
        SliderManager.shared.configureSlider(for: cell)
    }
    
    // Method for setting PageControl
    func setupPageControlForCustomCell(pageControl: UIPageControl, numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
    
    // MARK: Second custom cell
    
    // Setting up a nested table controller
    func setupNestedTableViewControllerInCell(for cell: UITableViewCell) {
        guard let checkedCell = cell as? Main2TableViewCell else { return }
        TableViewManager.shared.setupNestedTableViewControllerInCell(for: checkedCell as Main2TableViewCell)
    }
    
    // Customizing cell appearance
    func setupViewAppearance(customCell: UITableViewCell) {
        TableViewManager.shared.setupViewAppearance(customCell: customCell)
    }
    
    // MARK: - Second screen
    
    func setupSecondScreenUI(
        viewController: UIViewController,
        tableView: UITableView,
        navigationTitle: String,
        url: String,
        completion: @escaping (Rooms) -> Void
    ) {
        // Setting delegates to control table behavior
        tableView.delegate = viewController as? UITableViewDelegate
        tableView.dataSource = viewController as? UITableViewDataSource
        
        // Customizing the Navigation Bar
        UtilityManager.shared.setupNavigationBar(for: viewController)
        
        // Registering XIB for table cells
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsCell")
        
        // Set the title as the hotel name
        viewController.navigationItem.title = navigationTitle
        
        // Querying data from a remote server for a data model
        NetworkManager.shared.getDataFromRemoteServer(urlString: url, from: viewController, tableView: tableView) { roomsData in
            completion(roomsData)
        }
    }
    
    // MARK: Custom cell
    
    func setupCustomCellForSecondScreen(
        chooseRoomButton: UIButton,
        viewWithPagination: UIView,
        collectionView: UICollectionView,
        moreAboutRoomButton: UIButton,
        cell: UITableViewCell
    ) {
        // Setting the rounding of a button
        UtilityManager.shared.cornerRadius(for: chooseRoomButton, radius: 15)
        
        // Setting the cell view
        TableViewManager.shared.setupViewAppearance(customCell: cell)
        
        // Registering XIB for collectionView
        let nib = UINib(nibName: "SecondCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "СollectionViewCell")
        
        // Setting view rounding for pagination
        UtilityManager.shared.cornerRadius(for: viewWithPagination, radius: 5)
        
        // Rounding collectionView corners
        UtilityManager.shared.cornerRadius(for: collectionView, radius: 15)
        
        // Rounding the moreAboutRoomButton
        UtilityManager.shared.cornerRadius(for: moreAboutRoomButton, radius: 5)
        
        // Setting the background color of the UICollectionView to white
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Third screen
    
    // Rounding views
    func setupViewElements(views: [UIView]) {
        for view in views {
            UtilityManager.shared.cornerRadius(for: view, radius: 15)
        }
    }
    
    // Rounding buttons in sections
    func setupButtons(buttons: [UIButton], radius: CGFloat) {
        for button in buttons {
            UtilityManager.shared.cornerRadius(for: button, radius: radius)
        }
    }
    
    // Setting up text fields
    func setupTextFields(textFields: [UITextField], radius: CGFloat) {
        TextFieldManager.shared.textFiledsConfig(for: textFields, radius: radius)
    }
    
    // Setting up a stack with hotel ratings
    func setupStackViewWithStar(stackView: UIStackView) {
        UtilityManager.shared.hotelLevel(stackView: stackView)
    }
    
    // Add a border to the bottom view with a button
    func setupViewWithBorder(view: UIView) {
        UtilityManager.shared.configureBordersForBottomView(view: view)
    }
    
    // Setting keyboard behavior
    func setupKeyboardHiding(viewController: UIViewController, scrollView: UIScrollView) {
        TextFieldManager.shared.setupGestureToHideKeyboard(viewController: viewController)
        ScrollViewManager.shared.setupToHideKeyboardOnScroll(scrollView: scrollView, viewController: viewController)
    }
    
    // MARK: - Fourth screen
    
    func setupFourthScreenUI(superButton: UIButton, bottomViewWithButton: UIView, viewWithImage: UIView, orderConfirmation: UILabel) {
        
        // Rounding out the Super button!
        UtilityManager.shared.cornerRadius(for: superButton, radius: 15)
        
        // Setting a border for the bottom view
        UtilityManager.shared.configureBordersForBottomView(view: bottomViewWithButton)
        
        // Making a circle from a view with a congratulatory image
        viewWithImage.layer.cornerRadius = viewWithImage.frame.size.width / 2
        
        // Order confirmation text
        orderConfirmation.text = UtilityManager.shared.orderConfirmation()
    }
    
}
