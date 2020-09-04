//
//  EventDetailCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 04/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class EventDetailCoordinator: Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        
    }
}
