//
//  EventCellViewModel.swift
//  EventApp
//
//  Created by Chirag's on 03/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
struct EventCellViewModel {
    let date = Date()
    var timeRemainingStrings: [String]  {
        guard let eventDate = event.date else { return []}
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String {
        "25 Mar 2020"
    }
    var eventName: String {
        "Barbados"
    }
    
    var backgroundImage: UIImage {
         #imageLiteral(resourceName: "newyear")
    }
    private let event: Event
    init(_ event: Event) {
        self.event = event
    }
}
