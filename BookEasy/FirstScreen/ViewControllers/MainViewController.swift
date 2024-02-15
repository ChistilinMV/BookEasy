//
//  MainViewController.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    // Singleton data model for storing hotel information, although the structure does not need a singleton
    private var dataModelHotel = Hotel.shared
    
    // For later use for a white background under the table when it is pulled down
    private let whiteView = UIView()
    
    // Урл для URLSession
    private let url = "https://run.mocky.io/v3/d0c6ca70-ee95-4a7d-899d-0ad2310eb06f"
    
    // Create an instance of the FirstScreenUISettings structure
    lazy var settings = FirstScreenUISettings(
        viewController: self,
        tableView: tableView,
        blueButton: blueButton,
        bottomViewWithButton: bottomViewWithButton,
        whiteView: whiteView,
        navigationTitle: nil,
        url: url,
        completion: { [weak self] hotelData in
            self?.dataModelHotel = hotelData
        }
    )
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomViewWithButton: UIView!
    @IBOutlet weak var blueButton: UIButton!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI setup
        UIManager.shared.setupFirstScreenUI(for: settings)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // We update the width of the whiteView to match the width of the tableView so that when the table is pulled down on large screens, a gray bar does not appear on the right
        whiteView.frame.size.width = tableView.bounds.width
        
        // Set additional bottom margin for tableView
        TableViewManager.shared.additionalPadding(for: -29, tableView: tableView, view: view)
    }
    
    // MARK: - IB Actions
    
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        
        // Setting up the back button
        UtilityManager.shared.changeBackButtonTextAndColor(for: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondViewController = segue.destination as? SecondViewController else { return }
        secondViewController.navigationTitle = dataModelHotel.name
    }
    
}

// MARK: - Table View

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            // Register the cell and cast it as custom
            guard let mainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
            
            // Setting up a custom cell
            mainCell.configCell(dataModel: dataModelHotel)
            
            return mainCell
            
        } else {
            
            // Register the cell and cast it as custom
            guard let mainSecondCell = tableView.dequeueReusableCell(withIdentifier: "MainSecondCell", for: indexPath) as? Main2TableViewCell else { return UITableViewCell() }
            
            // Setting up a custom cell
            mainSecondCell.configCell(dataModel: dataModelHotel, indexPath: indexPath)
            
            return mainSecondCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
}
