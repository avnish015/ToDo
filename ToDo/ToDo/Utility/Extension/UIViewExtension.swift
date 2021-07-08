//
//  UIViewExtension.swift
//  ToDo
//
//  Created by Avnish Kumar on 06/07/21.
//

import UIKit


extension UIView {
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
        self.cornerRadius = self.frame.width/2
    }
    
   var cornerRadius:CGFloat {
        set {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = newValue
//            self.layer.borderWidth = 2
//            self.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
    
    var boarderWidth:CGFloat {
        set {
            self.layer.masksToBounds = false
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        get {
            return self.layer.borderWidth
        }
    }
}
