//
//  UIColorExtension.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import UIKit

extension UIColor {
    static func getRandomColor(index:Int) -> UIColor {
        let colors =  [#colorLiteral(red: 0.9005355239, green: 0.7733876109, blue: 0.9052463174, alpha: 1), #colorLiteral(red: 0.6965607979, green: 0.8985797254, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.9438357135, blue: 0.8879349478, alpha: 1), #colorLiteral(red: 0.9116621614, green: 0.9984067082, blue: 0.8782256246, alpha: 1), #colorLiteral(red: 0.5598827403, green: 0.81604761, blue: 1, alpha: 1)]
        let nextIndex = index % colors.count
        return colors[nextIndex]
    }
}
