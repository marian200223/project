//
//  Alert.swift
//  TrainApp
//
//  Created by Marian Iconaru on 9/12/20.
//

import Foundation
import UIKit

struct Alert {
    static func showAlert(title: String = "", message: String?, cancelButton: Bool = false, completion: ( () -> Void )? = nil ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            guard let completion = completion else {
                return
            }
            completion()
        }
        alert.addAction(action)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if cancelButton {
            alert.addAction(cancel)
        }
        return alert
    }
}
