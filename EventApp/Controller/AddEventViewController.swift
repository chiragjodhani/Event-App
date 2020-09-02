//
//  AddEventViewController.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel: AddEventViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(TitleSubTitleCell.self, forCellReuseIdentifier: "TitleSubTitleCell")
        tableView.tableFooterView = UIView()
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .black
        //to force large titles
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    @objc private func tappedDone(){
        viewModel.tappedDone()
    }
}

extension AddEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleSubTitleCell", for: indexPath) as! TitleSubTitleCell
            cell.update(with: titleSubtitleCellViewModel)
            return cell
        case .titleImage:
            return UITableViewCell()
        }
    }
}
