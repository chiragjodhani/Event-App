//
//  EventDetailViewController.swift
//  EventApp
//
//  Created by Chirag's on 04/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    var viewModel: EventDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else {
                return
            }
            self.backgroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
