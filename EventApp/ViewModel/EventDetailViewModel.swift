//
//  EventDetailViewModel.swift
//  EventApp
//
//  Created by Chirag's on 04/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
import CoreData
final class EventDetailViewModel {
    private let eventId: NSManagedObjectID
    private let eventService: EventServiceProtocol
    private var event: Event?
    private let date = Date()
    var onUpdate = {}
    var coordinator: EventDetailCoordinator?
    var image: UIImage? {
        guard let imageData = event?.image, let image = UIImage(data: imageData) else {
            return nil
        }
        return image
    }
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil}
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    init(eventID: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
        self.eventId = eventID
        self.eventService = eventService
    }
    
    func viewDidLoad(){
        reload()
    }
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    func reload(){
        self.event = eventService.getEvent(eventId)
        onUpdate()
    }
    
    @objc func editButtonTapped(){
        guard let event = self.event else {
            return
        }
        coordinator?.onEditEvent(event)
    }
}
