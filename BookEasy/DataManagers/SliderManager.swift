//
//  SliderManager.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

protocol SliderManagerDelegate: AnyObject {
    func imageUrls(for sliderManager: SliderManager) -> [String]
}

protocol  SliderImageViewCell {
    var imageView: UIImageView! { get }
}

protocol ConfigurableCell {
    var collectionView: UICollectionView! { get set }
    var pageControl: CustomPageControl! { get set }
}

class SliderManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    // Singleton is an instance of a class to avoid multiple instances of this class in different parts of the application
    static let shared = SliderManager()
    
    // List of Image URLs
    var imageUrls: [String] = []
    
    // Делагат
    weak var delegate: SliderManagerDelegate?
    
    // Current collection of images for the slider
    weak var currentCollectionView: UICollectionView?
    
    // A UIPageControl control to display the current slider page
    weak var currentPageControl: CustomPageControl?
    
}

// MARK: - Methods

extension SliderManager {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "СollectionViewCell", for: indexPath) as? UICollectionViewCell & SliderImageViewCell else {
                fatalError("Не удалось создать ячейку, соответствующую протоколу SliderImageViewCell")
            }
        
        // Round corners for first and last cell
        if indexPath.row == 0 {
            cell.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else if indexPath.row == imageUrls.count - 1 {
            cell.imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        } else {
            cell.imageView.layer.maskedCorners = []
        }
        
        UtilityManager.shared.cornerRadius(for: cell.imageView, radius: 15)
        
        // Checking for URLs
        guard !imageUrls.isEmpty else {
            return cell
        }
        
        // Loading and setting an image from a URL
        let urlStr = imageUrls[indexPath.row]
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    Logger.log("Ошибка загрузки изображения: \(error.localizedDescription)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                } else {
                    Logger.log("Не удалось загрузить изображение")
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(named: "noImage")
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // MARK: UIScrollViewDelegate
    
    // The method is called when scroll deceleration is complete, updating the current page indicator in the UIPageControl
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        
        // Getting the width of one page (or cell) in collectionView
        let pageWidth = collectionView.frame.size.width
        
        // We calculate the current page based on the horizontal offset of the collectionView divided by the page width.
        let currentPage = Int(collectionView.contentOffset.x / pageWidth)
        
        // Find pageControl and set the current page
        currentPageControl?.currentPage = currentPage
    }
    
    // MARK: Page Control
    
    @objc 
    func pageControlDidChange(sender: UIPageControl) {
        guard let collectionView = currentCollectionView else { return }
        changePage(sender: sender, collectionView: collectionView)
        
        // Setting currentPage for custom pageControl
        currentPageControl?.currentPage = sender.currentPage
    }
    
    // Method responding to changes in the selected page in UIPageControl
    func changePage(sender: UIPageControl, collectionView: UICollectionView) {
        // We calculate the new scroll position by multiplying the currently selected page by the width of the collection cell.
        let currentPageOffset = CGFloat(sender.currentPage) * collectionView.frame.size.width
        
        // Set a new scroll position for the collection, creating a CGPoint with a new x value and the current y value (which remains 0 since scrolling is horizontal)
        collectionView.setContentOffset(CGPoint(x: currentPageOffset, y: 0), animated: true)
    }
    
    // MARK: Configuring the slider
    
    func configureSlider<T: ConfigurableCell>(for cell: T) {
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.pageControl.addTarget(self, action: #selector(pageControlDidChange(sender:)), for: .valueChanged)
            self.currentCollectionView = cell.collectionView
            self.currentPageControl = cell.pageControl
            cell.collectionView.reloadData()
        }

}
