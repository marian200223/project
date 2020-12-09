//
//  Spinner.swift
//  TrainApp
//
//  Created by Marian Iconaru on 6/12/20.
//

import Foundation
import UIKit

class Spinner {
    
    static let shared = Spinner()
    static var shown: Bool = false
    var loadingView = UIView()
    var spinner = UIActivityIndicatorView(style: .large)
    
    private init() {
    }
    
    func showActivityIndicator(view: UIView) {
        if !Spinner.shown {
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.loadingView.removeFromSuperview()
                self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
                self.loadingView.center = view.center
                self.loadingView.backgroundColor = UIColor.clear
                self.loadingView.alpha = 0.7
                self.loadingView.clipsToBounds = true
                self.loadingView.layer.cornerRadius = 10
                
                self.spinner = UIActivityIndicatorView(style: .large)
                self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
                self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
                
                self.loadingView.addSubview(self.spinner)
                view.addSubview(self.loadingView)
                self.spinner.startAnimating()
                Spinner.shown = true
            }
        }
    }
    
    func hideActivityIndicator(completion: (() ->Void)?) {
        Spinner.shown = false
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
            if let completion = completion {
                completion()
            }
        }
    }
}
