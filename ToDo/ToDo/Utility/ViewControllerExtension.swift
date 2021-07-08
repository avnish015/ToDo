//
//  ViewControllerExtension.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import UIKit

extension UIViewController {
   func hideKeyboardWhenTappedAround() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
   }
   @objc func dismissKeyboard() {
       view.endEditing(true)
   }
}
