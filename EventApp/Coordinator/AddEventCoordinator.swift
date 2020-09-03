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
    private var modalNavigationController: UINavigationController?
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventCoordinator?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel(cellBuilder: EventCellBuilder(), coreDataManager: CoreDataManager())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(childCoordinator:self)
    }
    func didFinishSaveEvent(){
        navigationController.dismiss(animated: true, completion: nil)
    }
    func showImagePicker(completion: @escaping(UIImage) -> Void) {
        guard let  modalNavigationController = self.modalNavigationController else {
            return
        }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion(image)
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    func childDidFinish(childCoordinator: Coordiantor){
        if let index = self.childCoordinators.firstIndex(where: { coordinator -> Bool in
            return  childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
