//
//  FirstScreenUISettings.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

struct FirstScreenUISettings {
    let viewController: UIViewController
    let tableView: UITableView
    let blueButton: UIButton
    let bottomViewWithButton: UIView
    let whiteView: UIView
    let navigationTitle: String?
    let url: String
    let completion: (Hotel) -> Void
}
