//
//  ViewController.swift
//  Example-swift
//
//  Created by Paul-Emmanuel on 05/01/17.
//  Copyright © 2017 rstudio. All rights reserved.
//

import UIKit

import InstaZoom

extension UIColor {
    class var activated: UIColor {
        get {
            return UIColor(colorLiteralRed: 50/255.0, green: 205/255.0, blue: 50/255.0, alpha: 1)
        }
    }

    class var deactivated: UIColor {
        get {
            return UIColor(colorLiteralRed: 220/255.0, green: 20/255.0, blue: 60/255.0, alpha: 1)
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toggleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.isPinchable = true
        toggleButton.setTitleColor(.activated, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleIsPinchable(_ sender: Any) {
        imageView.isPinchable = !imageView.isPinchable
        toggleButton.setTitleColor((imageView.isPinchable) ? .activated : .deactivated, for: .normal)
    }

}

