//
//  SecondCollectionViewCell.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {

    // MARK: - IB Outlets
    
    // Outlet for UIImageView that will display an image in a cell
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - Slider Delegate

extension SecondCollectionViewCell: SliderImageViewCell {}
