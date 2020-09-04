//
//  EventDetailCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 04/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
import CoreData
final class EventDetailCoordinator: Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventCoordinator?
    init(eventID: NSManagedObjectID,navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    func start() {
        let detailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        detailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    func didFinish(){
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
}
