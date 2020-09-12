//
//  EditEventViewModel.swift
//  EventApp
//
//  Created by Chirag's on 12/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
import UIKit
import CoreData
final class EditEventViewModel {
    let title = "Edit"
    var onUpdate: () -> Void = {}
    enum Cell {
        case titleSubtitle(TitleSubTitleCellViewModel)
    }
    private(set) var cells: [EditEventViewModel.Cell] = []
    weak var coordinator: EditEventCoordinator?
    
    var nameCellViewModel: TitleSubTitleCellViewModel?
    var dateCellViewModel: TitleSubTitleCellViewModel?
    var backgroundImageCellViewModel: TitleSubTitleCellViewModel?
    private let cellBuilder: EventCellBuilder
    private let eventService: EventServiceProtocol
    private let event: Event
    lazy var dateFormmater: DateFormatter = {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "dd.MM.yyy"
        return dateFormmater
    }()
    
    init(event: Event,cellBuilder: EventCellBuilder, eventService: EventServiceProtocol = EventService()) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.eventService = eventService
    }
    func viewDidLoad() {
        self.setupCells()
        onUpdate()
    }
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int{
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone(){
        guard let name = nameCellViewModel?.subTitle, let dateString = dateCellViewModel?.subTitle, let image = backgroundImageCellViewModel?.image, let date = dateFormmater.date(from: dateString) else {
            return
        }
        eventService.perform(.update(event), data: EventService.EventInputData(name: name, date: date, image: image))
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubTitleCellViewModel):
            guard titleSubTitleCellViewModel.type == .image else {
                return
            }
            coordinator?.showImagePicker { image in
                titleSubTitleCellViewModel.update(image: image)
            }
        }
    }
}

private extension EditEventViewModel {
    func setupCells(){
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel =  cellBuilder.makeTitleSubtitleCellViewModel(.image){ [weak self] in
            self?.onUpdate()
        }
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]
        guard let name = event.name, let date = event.date, let imageData = event.image, let image = UIImage(data: imageData) else {
            return
        }
        nameCellViewModel.update(name)
        dateCellViewModel.update(date: date)
        backgroundImageCellViewModel.update(image: image)
    }
}

