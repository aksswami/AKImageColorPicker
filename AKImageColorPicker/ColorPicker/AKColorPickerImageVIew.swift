//
//  AKColorPickerImageVIew.swift
//  AKImageColorPicker
//
//  Created by Amit Kumar Swami on 18/09/17.
//  Copyright © 2017 Aks. All rights reserved.
//

import Foundation
import UIKit

protocol AKColorPickerImageViewDelegate: class {
    func didPickColor(with color: UIColor, in imageView: UIImageView)
}

class AKColorPickerImageView: UIImageView {
    var lensStartPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            lensView.frame.origin = lensStartPoint
        }
    }
    weak var delegate: AKColorPickerImageViewDelegate?
    private lazy var lensView: UIView = {
        let view = UIView(frame: CGRect(origin: lensStartPoint, size: CGSize(width: 50, height: 50)))
        view.layer.cornerRadius = view.frame.width * 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.contentsScale = UIScreen.main.scale
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    private func setup() {
        isUserInteractionEnabled = true
        addSubview(lensView)
    }
    
    // MARK:- handle touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        pickerColor(at: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if self.bounds.contains(location) {
            pickerColor(at: location)
        }
    }
    
    func pickerColor(at point: CGPoint) {
        UIView.animate(withDuration: 0.1) {
            self.lensView.center = point
        }
        guard let convertPoint = image?.convert(viewPoint: point, for: self),
            let color = image?.pickColor(for: convertPoint)
            else { return }
        
        lensView.backgroundColor = color
        delegate?.didPickColor(with: color, in: self)
    }
}
