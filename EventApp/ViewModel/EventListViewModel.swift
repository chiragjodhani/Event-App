//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
final class EventListViewModel {
    let title = "Events"
    var coordinator: EventCoordinator?
    func tappedAddEvent() {
        coordinator?.startAddEvent()
        
    }
}
