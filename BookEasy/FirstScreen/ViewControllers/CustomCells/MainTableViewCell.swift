//
//  MainTableViewCell.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Array of URL strings for loading images for the slider
    private var imageUrls: [String] = []
    
    // Create a new CAShapeLayer object that will serve as a mask for the layer
    private let maskLayer = CAShapeLayer()
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var hotelAdress: UIButton!
    @IBOutlet weak var priceFor: UILabel!
    @IBOutlet weak var minimalPrice: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var ratingText: UILabel!
    @IBOutlet weak var stackViewWithStar: UIStackView!
    @IBOutlet weak var viewWithPagination: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initial UI setup
        setupUI()
    }
    
    // MARK: - layoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Round the corners of the cell only at the bottom
        maskLayer.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: 15, height: 15)).cgPath
    }
    
    // MARK: - IB Actions
    
    // Method called when the hotel address button is clicked
    @IBAction func hotelAdressButttonTapped(_ sender: UIButton) {
        Logger.log("The \"Адреса отеля\" button was pressed, but has not yet been implemented")
    }
    
}

// MARK: - Methods

extension MainTableViewCell {
    
    // MARK: Configuring the cell
    
    func configCell(dataModel: Hotel) {
        ratingText.text = dataModel.ratingName
        ratingNumber.text = String(dataModel.rating)
        hotelName.text = dataModel.name
        hotelAdress.setTitle(dataModel.adress, for: .normal)
        priceFor.text = dataModel.priceForIt
        minimalPrice.text = UtilityManager.shared.formatMinimalPrice(dataModel.minimalPrice)
        
        // Installing images for the slider
        self.imageUrls = dataModel.imageUrls
        
        // Update the delegate and data source for collectionView
        SliderManager.shared.delegate = self
        SliderManager.shared.imageUrls = dataModel.imageUrls
        SliderManager.shared.configureSlider(for: self)
        
        pageControl.numberOfPages = imageUrls.count // Update the number of pages for pageControl
        collectionView.reloadData() // Reloading the collection data
    }
    
    // Method for initial UI setup
    private func setupUI() {
        UIManager.shared.setupFirstCustomCellForFirstScreen(customCell: self, shouldApplyCornerRadius: false)
        UIManager.shared.setupCustomCellStackView(stackView: stackViewWithStar)
        UIManager.shared.setupViewWithPaginationCornerRadius(for: viewWithPagination)
        UIManager.shared.setupCollectionViewCornerRadius(for: collectionView)
        UIManager.shared.registerCustomCellNibs(collectionView: collectionView)
        UIManager.shared.setupCustomCellCollectionViewBackgroundColor(collectionView: collectionView, color: .white)
    }
    
}

// MARK: - Slider Manager Delegate

extension MainTableViewCell: SliderManagerDelegate, ConfigurableCell {
    
    // The method returns an array of URLs that are used to display images in the slider
    func imageUrls(for sliderManager: SliderManager) -> [String] {
        return self.imageUrls
    }
    
}
