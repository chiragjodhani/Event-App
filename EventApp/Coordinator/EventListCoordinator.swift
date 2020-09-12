//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 01/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
import CoreData
final class EventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var onUpdateEvent = {}
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let eventListViewController: EventListViewController = .instantiate()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        onUpdateEvent = eventListViewModel.reload
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent(){
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(childCoordinator: Coordinator){
        if let index = self.childCoordinators.firstIndex(where: { coordinator -> Bool in
            return  childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(eventID: id, navigationController: navigationController)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()
    }
}
