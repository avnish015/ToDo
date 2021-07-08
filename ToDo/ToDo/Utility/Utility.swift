//
//  Utility.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import UIKit

class Utility {
    static func  showAlert(vc:UIViewController, title:String, message:String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc.present(alertVC, animated: true, completion: nil)
    }
}


