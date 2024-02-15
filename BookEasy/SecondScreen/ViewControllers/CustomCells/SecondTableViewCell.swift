//
//  SecondTableViewCell.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

protocol SecondTableViewCellDelegate: AnyObject {
    func chooseRoomButtonTapped(cell: SecondTableViewCell)
    func changeBackButtonTextAndColor()
}

class SecondTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Array of URL strings for loading images for the slider
    private var imageUrls: [String] = []
    
    // Create a separate slider instance
    private let slider = SliderManager()
    
    // Делегат
    weak var delegate: SecondTableViewCellDelegate?
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var chooseRoom: UIButton!
    @IBOutlet weak var includedInPrice: UILabel!
    @IBOutlet weak var minimalPrice: UILabel!
    @IBOutlet weak var moreAboutRoomButton: UIButton!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var viewWithPagination: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initial UI setup
        UIManager.shared.setupCustomCellForSecondScreen(
            chooseRoomButton: chooseRoom,
            viewWithPagination: viewWithPagination,
            collectionView: collectionView,
            moreAboutRoomButton: moreAboutRoomButton,
            cell: self
        )
        
        // setting target-action for the chooseRoomButtonTapped button
        chooseRoom.addTarget(self, action: #selector(chooseRoomButtonAction), for: .touchUpInside)
    }
    
    // MARK: - IB Actions
    
    @IBAction func aboutRoomButtonTapped(_ sender: UIButton) {
        Logger.log("The \"Подробнее о номере\" button was pressed, but has not yet been implemented")
    }
    
    @IBAction func chooseRoomButtonTapped(_ sender: UIButton) {
        delegate?.chooseRoomButtonTapped(cell: self)
    }
}

// MARK: - Methods

extension SecondTableViewCell {
    
    // For button target
    @objc
    func chooseRoomButtonAction() {
        delegate?.changeBackButtonTextAndColor()
    }
    
    // MARK: Configuring the cell
    
    func configCell(dataModel: Rooms, indexPath: IndexPath, delegate: SecondTableViewCellDelegate) {
        
        self.delegate = delegate
        roomDescription.text = dataModel.rooms[indexPath.section].name
        minimalPrice.text = UtilityManager.shared.formatMinimalPrice(dataModel.rooms[indexPath.section].price)
        includedInPrice.text = dataModel.rooms[indexPath.section].pricePer
        DynamicCreatingViewManager.shared.configLabelsWithData(with: dataModel.rooms[indexPath.section].peculiarities, verticalStackView: verticalStackView, customCell: self)
        
        // Installing images for the slider
        self.imageUrls = dataModel.rooms[indexPath.section].imageUrls
        
        // Update the delegate and data source for collectionView
        slider.delegate = self
        slider.imageUrls = dataModel.rooms[indexPath.section].imageUrls
        slider.configureSlider(for: self)
        
        pageControl.numberOfPages = imageUrls.count // Update the number of pages for pageControl
        collectionView.reloadData() // Reloading the collection data
    }
    
}

// MARK: - Slider Manager Delegate

extension SecondTableViewCell: SliderManagerDelegate, ConfigurableCell {
        
    // The method returns an array of URLs that are used to display images in the slider
    func imageUrls(for sliderManager: SliderManager) -> [String] {
        return self.imageUrls
    }
    
}
