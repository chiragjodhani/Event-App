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
        case titleImage
    }
    private(set) var cells: [AddEventViewModel.Cell] = []
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(TitleSubTitleCellViewModel("Name", "", "Add a name")),
            .titleSubtitle(TitleSubTitleCellViewModel("Date", "", "Select a date"))
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
}



