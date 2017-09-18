//
//  UIImage+ColorPicker.swift
//  AKImageColorPicker
//
//  Created by Amit Kumar Swami on 18/09/17.
//  Copyright © 2017 Aks. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    func pickColor(for point: CGPoint) -> UIColor? {
        let cgImage = self.cgImage
        let colorSpace: CGFloat = 255.0
        guard let width = cgImage?.width,
            let height = cgImage?.height
            else {
                return nil
        }
        let x: Int = Int(floor(point.x) * self.scale)
        let y: Int = Int(floor(point.y) * self.scale)
        
        if (x < width) && (y < height) {
            guard let provider = cgImage?.dataProvider,
                let bitmapData = provider.data,
                let data = CFDataGetBytePtr(bitmapData)
                else { return nil }
            
            let offset = ((width * y) + x) * 4
            
            let red = CGFloat(data[offset])
            let green = CGFloat(data[offset + 1])
            let blue = CGFloat(data[offset + 2])
            let alpha = CGFloat(data[offset + 3])
            
            return UIColor(red: red/colorSpace, green: green/colorSpace, blue: blue/colorSpace, alpha: alpha/colorSpace)
        }
        
        return nil
    }
    
    func convert(viewPoint: CGPoint, for imageView: UIImageView) -> CGPoint {
        var imagePoint = viewPoint
        let imageSize = size
        let viewSize = imageView.bounds.size
        
        let ratioX = viewSize.width / imageSize.width
        let ratioY = viewSize.height / imageSize.height
        
        switch imageView.contentMode {

        case .topLeft:
            break
        case .scaleAspectFit, .scaleAspectFill:
            let scale = imageView.contentMode == .scaleAspectFit ? min(ratioX, ratioY) : max(ratioX, ratioY)
            
            // Remove the x or y margin added in FitMode
            imagePoint.x -= (viewSize.width - imageSize.width * scale) / 2.0
            imagePoint.y -= (viewSize.height - imageSize.height * scale) / 2.0
            
            imagePoint.x /= scale
            imagePoint.y /= scale
 
        case .redraw, .scaleToFill:
            imagePoint.x /= ratioX
            imagePoint.y /= ratioY
        case .center:
            imagePoint.x -= (viewSize.width - imageSize.width) / 2.0
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0
        case .top:
            imagePoint.x -= (viewSize.width - imageSize.width) / 2.0
        case .bottom:
            imagePoint.x -= (viewSize.width - imageSize.width) / 2.0
            imagePoint.y -= (viewSize.height - imageSize.height)
        case .left:
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0
        case .right:
            imagePoint.x -= (viewSize.width - imageSize.width)
            imagePoint.y -= (viewSize.height - imageSize.height) / 2.0
        case .topRight:
            imagePoint.x -= (viewSize.width - imageSize.width)
        case .bottomLeft:
            imagePoint.y -= (viewSize.height - imageSize.height)
        case .bottomRight:
            imagePoint.x -= (viewSize.width - imageSize.width)
            imagePoint.y -= (viewSize.height - imageSize.height)
        }
        
        return imagePoint
    }
}
