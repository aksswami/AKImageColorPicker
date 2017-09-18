//
//  ViewController.swift
//  AKImageColorPicker
//
//  Created by Amit Kumar Swami on 18/09/17.
//  Copyright © 2017 Aks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickedColorView: UIView!
    @IBOutlet weak var colorPickerImageView: AKColorPickerImageView! {
        didSet {
            colorPickerImageView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: AKColorPickerImageViewDelegate {
    func didPickColor(with color: UIColor, in imageView: UIImageView) {
        pickedColorView.backgroundColor = color
    }
}

