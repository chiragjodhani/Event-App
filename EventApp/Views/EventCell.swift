//
//  EventCell.swift
//  EventApp
//
//  Created by Chirag's on 03/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class EventCell: UITableViewCell {
    
    private let timeRemainingStackView = TimeRemainingStackView()
    private let dateLabel = UILabel()
    
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        timeRemainingStackView.setup()
        [dateLabel,eventNameLabel,backgroundImageView, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func setupHierarchy() {
        contentView.addSubview(self.backgroundImageView)
        contentView.addSubview(self.verticalStackView)
        contentView.addSubview(self.eventNameLabel)
            
        self.verticalStackView.addArrangedSubview(timeRemainingStackView)
        self.verticalStackView.addArrangedSubview(UIView())
        self.verticalStackView.addArrangedSubview(dateLabel)
    }
    private func  setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom],constant: 15)
    }
    
    func update(with viewModel: EventCellViewModel) {
        guard let timeRemainingViewModel = viewModel.timeRemainingViewModel else {
            return
        }
        timeRemainingStackView.update(with: timeRemainingViewModel)
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        viewModel.loadImage { (image) in
            self.backgroundImageView.image = image ?? UIImage()
        }
    }
}
