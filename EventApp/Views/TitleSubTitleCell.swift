//
//  TitleSubTitleCell.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit
final class TitleSubTitleCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let subTitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant: CGFloat = 15
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(with viewModel:TitleSubTitleCellViewModel){
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder
    }
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subTitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        [verticalStackView, titleLabel, subTitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subTitleTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -constant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: constant),
        ])
    }
    
}
