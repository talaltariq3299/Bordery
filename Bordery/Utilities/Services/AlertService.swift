//
//  AlertService.swift
//  Bordery
//
//  Created by Kevin Laminto on 1/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit
struct AlertService {
    /**
     * Display the alert to the users.
     * - viewController: The view controller that will display the alert.
     * - title: The main title of the alert.
     * - message: The message of the alert.
     */
    static func alert(_ viewController: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func alertAction(_ viewController: UIViewController, title: String, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
}
