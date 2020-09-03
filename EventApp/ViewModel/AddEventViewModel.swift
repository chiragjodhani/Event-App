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
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubTitleCellViewModel("Name", "", "Add a name", .text, onCellUpdate: {})),
            .titleSubtitle(TitleSubTitleCellViewModel("Date", "", "Select a date", .date, onCellUpdate: { [weak self] in
                self?.onUpdate()
            })),
            .titleSubtitle(TitleSubTitleCellViewModel("Background", "", "", .image, onCellUpdate: {}))
        ]
        onUpdate()
    }
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int{
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone(){
        print("TappedDone")
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
}



