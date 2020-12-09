//
//  UITextField+ext.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import UIKit

extension UITextField {
    
    func isComplete(filled: Bool) {
        if filled {
            self.layer.borderColor = UIColor.black.cgColor
        } else {
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func setUpBorderLayout() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
