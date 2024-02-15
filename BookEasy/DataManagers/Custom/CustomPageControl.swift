//
//  CustomPageControl.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

class CustomPageControl: UIPageControl {
    
    // MARK: - Strutc
    
    // Constants used in the class
    private enum Constants {
        static let cornerRadius: CGFloat = 5.0
        static let containerInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 9)
        static let maxAlpha: CGFloat = 1
        static let minAlpha: CGFloat = 0.2
    }
    
    // MARK: - Properties
    
    private var dotViews: [UIView] = [] // Array for storing view points
    private let dotSize: CGFloat = 7.0 // Points size
    private let dotSpacing: CGFloat = 5.0 // Distance between points
    var currentButtonColor: UIColor = .black // Active button color
    private let originalDotColor = UIColor.gray // Button color and applying an alpha channel to that color
    
    // Background for view-points
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    // Page count override
    override var numberOfPages: Int {
        didSet {
            setupDotViews()
        }
    }
    
    // Overriding the current page
    override var currentPage: Int {
        didSet {
            updateDotColors()
        }
    }
    
    // MARK: - Intit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPageControl()
    }
    
    // MARK: - layoutSubviews
    
    // Arrange view points and background
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let totalWidth = CGFloat(numberOfPages) * dotSize + CGFloat(max(0, numberOfPages - 1)) * dotSpacing
        let startX = (bounds.width - totalWidth) / 2
        
        backgroundView.frame = CGRect(x: startX - Constants.containerInset.left,
                                      y: (bounds.height - dotSize) / 2 - Constants.containerInset.top,
                                      width: totalWidth + Constants.containerInset.left + Constants.containerInset.right,
                                      height: dotSize + Constants.containerInset.top + Constants.containerInset.bottom)
        
        for (index, dotView) in dotViews.enumerated() {
            let dotPositionX = startX + CGFloat(index) * (dotSize + dotSpacing)
            dotView.frame = CGRect(x: dotPositionX - (startX - Constants.containerInset.left),
                                   y: Constants.containerInset.top,
                                   width: dotSize,
                                   height: dotSize)
        }
    }
}

// MARK: - Methods

extension CustomPageControl {
    
    // Hiding the original page control
    private func setupPageControl() {
        self.pageIndicatorTintColor = .clear
        self.currentPageIndicatorTintColor = .clear
    }
    
    // Creating and setting up view points
    private func setupDotViews() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews = []
        
        addSubview(backgroundView)
        
        for _ in 0..<numberOfPages {
            let dotView = UIView()
            dotView.layer.cornerRadius = dotSize / 2
            backgroundView.addSubview(dotView)
            dotViews.append(dotView)
        }
        updateDotColors()
        setNeedsLayout()
    }
    
    // Update view point colors and transparency
    private func updateDotColors() {
        for (index, dotView) in dotViews.enumerated() {
            let alpha: CGFloat
            if index == currentPage {
                alpha = Constants.maxAlpha
                dotView.backgroundColor = currentButtonColor
            } else {
                let distanceToFirst = index
                // Calculate transparency depending on the distance to the first point
                alpha = Constants.maxAlpha - CGFloat(distanceToFirst) * (Constants.maxAlpha - Constants.minAlpha) / CGFloat(numberOfPages - 1)
                dotView.backgroundColor = originalDotColor
            }
            dotView.alpha = alpha
            dotView.frame.size = CGSize(width: dotSize, height: dotSize) // Setting the button size
        }
    }
    
}
