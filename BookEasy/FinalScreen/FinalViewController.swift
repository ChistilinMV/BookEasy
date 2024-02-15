//
//  FinalViewController.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class FinalViewController: UIViewController {

    // MARK: - IB Outlets
    
    // Outlets for various UI elements
    @IBOutlet weak var orderConfirmation: UILabel!
    @IBOutlet weak var bottomViewWithButton: UIView!
    @IBOutlet weak var viewWithImage: UIView!
    @IBOutlet weak var superButton: UIButton!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI setup
        UIManager.shared.setupFourthScreenUI(
            superButton: superButton,
            bottomViewWithButton: bottomViewWithButton,
            viewWithImage: viewWithImage,
            orderConfirmation: orderConfirmation
        )
    }
    
    // Returns to the start screen
    @IBAction func superButtonTapped(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
