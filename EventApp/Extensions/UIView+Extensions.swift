//
//  UIView+Extensions.swift
//  EventApp
//
//  Created by Chirag's on 03/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
enum Edge {
    case left
    case top
    case right
    case bottom
}
extension UIView {
    func pinToSuperviewEdges(_ edges: [Edge] = [.top, .left, .right, .bottom], constant: CGFloat = 0) {
        guard let superView = superview else {return}
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superView.bottomAnchor,constant: -constant).isActive = true
            }
        }
    }
}
