//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get}
    func start()
    func childDidFinish(_ childcoordinator: Coordinator)
}
extension Coordinator {
    func childDidFinish(_ childcoordinator: Coordinator) {}
}
final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
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
