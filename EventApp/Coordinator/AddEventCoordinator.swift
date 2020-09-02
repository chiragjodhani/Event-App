//
//  AddEventCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class AddEventCoordinator: Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    private let navigationController: UINavigationController
    
    var parentCoordinator: EventCoordinator?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        modalNavigationController.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
    
    func didFinishAddEvent(){
        parentCoordinator?.childDidFinish(childCoordinator:self)
    }
}
