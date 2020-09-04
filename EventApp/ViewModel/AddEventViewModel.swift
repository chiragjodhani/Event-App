//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//
import UIKit
import Foundation
final class AddEventViewModel {
    let title = "Add"
    var onUpdate: () -> Void = {}
    enum Cell {
        case titleSubtitle(TitleSubTitleCellViewModel)
    }
    private(set) var cells: [AddEventViewModel.Cell] = []
    weak var coordinator: AddEventCoordinator?
    
    var nameCellViewModel: TitleSubTitleCellViewModel?
    var dateCellViewModel: TitleSubTitleCellViewModel?
    var backgroundImageCellViewModel: TitleSubTitleCellViewModel?
    private let cellBuilder: EventCellBuilder
    private let coreDataManager: CoreDataManager
    
    lazy var dateFormmater: DateFormatter = {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "dd.MM.yyy"
        return dateFormmater
    }()
    
    init(cellBuilder: EventCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
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
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
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
    
    deinit {
        print("add event view model has been deallocated")
    }
}

private extension AddEventViewModel {
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
    }
}
