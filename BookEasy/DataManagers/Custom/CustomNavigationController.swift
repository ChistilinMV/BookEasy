//
//  CustomNavigationController.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MainViewController {
            viewController.navigationItem.leftBarButtonItem = nil
            return
        }
        
        let backButtonImage = UIImage(named: "right")?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        viewController.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    func backButtonTapped() {
        self.popViewController(animated: true)
    }
    
}
