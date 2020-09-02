//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
protocol Coordiantor: class {
    var childCoordinators: [Coordiantor] { get}
    func start()
}
final class AppCoordinator: Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    private let window: UIWindow
    
    init(window:  UIWindow) {
        self.window = window
    }
    func start() {
        let navigationController = UINavigationController()
        let eventCoordinator = EventCoordinator(navigationController: navigationController)
        childCoordinators.append(eventCoordinator)
        eventCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
