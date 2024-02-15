//
//  SecondViewController.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Properties
    
    // Getting the hotel name from the previous controller
    var navigationTitle: String?
    
    // Singleton data model for storing hotel information, although the structure does not need a singleton
    private var dataModelRooms = Rooms.shared
    
    // Урл для URLSession
    private let url = "https://run.mocky.io/v3/7365878b-2844-480d-89d2-28cb28fdbb72"
        
    // MARK: - IB Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstrantForTableView: NSLayoutConstraint!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI setup
        UIManager.shared.setupSecondScreenUI(
            viewController: self,
            tableView: tableView,
            navigationTitle: navigationTitle ?? "Default Title",
            url: url
        ) { [weak self] rooms in
            self?.dataModelRooms = rooms
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set additional bottom margin for tableView
        TableViewManager.shared.additionalPadding(for: -33, tableView: tableView, view: view)
    }
    
}

// MARK: - Table View

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModelRooms.rooms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Register the cell and cast it as custom
        guard let roomsCell = tableView.dequeueReusableCell(withIdentifier: "RoomsCell", for: indexPath) as? SecondTableViewCell else { return UITableViewCell() }
        
        // Setting up a custom cell
        roomsCell.configCell(dataModel: dataModelRooms, indexPath: indexPath, delegate: self)
        
        return roomsCell
    }
    
    // Set the footer height for the last section to create an indent
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    // Add a view to the footer to make it visible
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
}

extension SecondViewController: SecondTableViewCellDelegate {
    
    func chooseRoomButtonTapped(cell: SecondTableViewCell) {
            performSegue(withIdentifier: "ToCustomerScreen", sender: nil)
        }
    
    func changeBackButtonTextAndColor() {
            UtilityManager.shared.changeBackButtonTextAndColor(for: self)
        }
    
}

// MARK: - Scroll view delegate

extension SecondViewController {
    
    // Scroll view delegate method to remove the gray stripe at the top when scrolling the table up and make a simple border
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            topConstrantForTableView.constant = 1
        } else {
            topConstrantForTableView.constant = 8
        }
    }
}
