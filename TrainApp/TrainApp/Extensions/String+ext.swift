//
//  String+ext.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation

extension String {
    func urlFormatted() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    func firstLetterUppercase() -> String {
        let whiteSpace = NSCharacterSet.whitespaces
        let arrayOfWords = self.components(separatedBy: whiteSpace)
        var resultString = String()
        for (index, element) in arrayOfWords.enumerated() {
            resultString = resultString + element.prefix(1).capitalized + element.dropFirst().lowercased()
            if index < arrayOfWords.count - 1 {
                resultString += " "
            }
        }
        return resultString
    }
    
    func formatted() -> String {
        return self.firstLetterUppercase().urlFormatted()!
    }
}
