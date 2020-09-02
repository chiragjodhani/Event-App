//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
protocol Coordiantor {
    var childCoordinator: [Coordiantor] { get}
    func start()
}
final class AppCoordinator: Coordiantor {
    private(set) var childCoordinator: [Coordiantor] = []
    private let window: UIWindow
    
    init(window:  UIWindow) {
        self.window = window
    }
    func start() {
        let navigationController = UINavigationController()
        
        
        let eventCoordinator = EventCoordinator(navigationController: navigationController)
        
        childCoordinator.append(eventCoordinator)
        eventCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
