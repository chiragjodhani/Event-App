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
    var onUpdate = {}
    enum Cell {
        case event(EventCellViewModel)
    }
    private(set) var cells: [Cell] = []
    private var coreDataManager: CoreDataManager
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    func viewDidLoad(){
       reload()
    }
    
    func reload(){
        let events = coreDataManager.fetchEvent()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return  .event(eventCellViewModel)
        }
        onUpdate()
    }
    func tappedAddEvent() {
        coordinator?.startAddEvent()
        
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
