//
//  UIViewController+Extension.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}
