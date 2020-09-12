//
//  EditEventCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 12/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class EditEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventDetailCoordinator?
    
    private let event: Event
    init(event: Event, navigationController: UINavigationController) {
        self.event = event
        self.navigationController = navigationController
    }
    func start() {
        let editEventViewController: EditEventViewController = .instantiate()
        let editEventViewModel = EditEventViewModel(event: event, cellBuilder: EventCellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
    func didFinishUpdateEvent(){
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    func showImagePicker(completion: @escaping(UIImage) -> Void) {
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    func childDidFinish(childCoordinator: Coordinator){
        if let index = self.childCoordinators.firstIndex(where: { coordinator -> Bool in
            return  childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
