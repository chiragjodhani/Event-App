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
    let subTitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant: CGFloat = 15
    
    private let datePickerView = UIDatePicker()
    private let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoIamgeView = UIImageView()
    
    private var viewModel: TitleSubTitleCellViewModel?
    
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
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder
        
        subTitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subTitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        
        photoIamgeView.isHidden = viewModel.type != .image
        subTitleTextField.isHidden = viewModel.type == .image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subTitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
        
        [verticalStackView, titleLabel, subTitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        toolBar.setItems([doneButton], animated: false)
        datePickerView.datePickerMode = .date
        photoIamgeView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        photoIamgeView.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subTitleTextField)
        verticalStackView.addArrangedSubview(photoIamgeView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -constant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -constant),
        ])
        
        photoIamgeView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tappedDone(){
        viewModel?.update(date: datePickerView.date)
    }
}
