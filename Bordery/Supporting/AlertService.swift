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
     * Display the invalid alert to the users.
     * - viewController: The view controller that will display the alert.
     * - title: The main title of the alert.
     * - message: The message of the alert.
     */
    static func alert(_ viewController: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
