//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class EventCoordinator: Coordiantor {
    private(set) var childCoordinator: [Coordiantor] = []
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let eventListViewController = EventListViewController.instantiate()
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
}