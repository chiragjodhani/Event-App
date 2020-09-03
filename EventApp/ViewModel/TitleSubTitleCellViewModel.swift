//
//  TitleSubTitleCellViewModel.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//
import Foundation
import UIKit
final class TitleSubTitleCellViewModel {
    enum CellType {
        case text
        case date
        case image 
    }
    
    let title: String
    private(set) var subTitle: String
    private(set) var image: UIImage?
    let placeholder: String
    let type: CellType
    
    private(set) var onCellUpdate: (() -> Void)?
    lazy var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    init(_ title: String, _ subTitle: String, _ placeholder: String, _ type: CellType, onCellUpdate: (() -> Void)?) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String) {
        self.subTitle = subtitle
    }
    
    func update(date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subTitle = dateString
        onCellUpdate?()
    }
    func update(image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
