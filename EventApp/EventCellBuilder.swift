//
//  EventCellBuilder.swift
//  EventApp
//
//  Created by Chirag's on 03/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
struct EventCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubTitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubTitleCellViewModel {
        switch type {
        case .text:
            return TitleSubTitleCellViewModel("Name", "", "Add a name", .text, onCellUpdate: onCellUpdate)
        case .date:
            return TitleSubTitleCellViewModel("Date", "", "Select a date", .date, onCellUpdate:onCellUpdate)
        case .image:
            return TitleSubTitleCellViewModel("Background", "", "", .image, onCellUpdate: onCellUpdate)
            
        }
    }
}
