//
//  ImagePickerCoordinator.swift
//  EventApp
//
//  Created by Chirag's on 03/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
import UIKit
final class ImagePickerCoordinator: NSObject, Coordiantor {
    private(set) var childCoordinators: [Coordiantor] = []
    var parentCoordinator: AddEventCoordinator?
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        navigationController.present(imagePicker, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            parentCoordinator?.didFinishPicking(image)
        }
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
}
