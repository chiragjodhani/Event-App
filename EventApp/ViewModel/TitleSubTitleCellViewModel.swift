//
//  TitleSubTitleCellViewModel.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

final class TitleSubTitleCellViewModel {
    let title: String
    private(set) var subTitle: String
    let placeholder: String
    init(_ title: String, _ subTitle: String, _ placeholder: String) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
    }
}
