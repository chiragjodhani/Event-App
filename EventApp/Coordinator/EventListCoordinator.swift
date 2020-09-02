//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class EventCoordinator: Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let eventListViewController: EventListViewController = .instantiate()
        let evetnListViewModel = EventListViewModel()
        evetnListViewModel.coordinator = self
        eventListViewController.viewModel = evetnListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent(){
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(childCoordinator: Coordiantor){
        if let index = self.childCoordinators.firstIndex(where: { coordinator -> Bool in
            return  childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
