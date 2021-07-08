//
//  DateExtension.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import Foundation

extension Date {
     func dateInStringFormatFor() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.dateFormatter
        return dateFormatter.string(from: self)
    }
}
