//
//  String+extension.swift
//  BookEasy
//
//  Created by Max on 10/02/2024.
//

import UIKit

extension String {
    //Returns the width of a line given the height and font
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        // We create a rectangle with the maximum possible width and a given height to determine the maximum width that a given line can occupy
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        
        // Calculate and return the width of a line using the boundingRect method
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font], // Set the font for calculating the line size
            context: nil
        )
        
        // Return the width of the bounding box, rounded up to avoid possible text clipping
        return ceil(boundingBox.width)
    }
}
