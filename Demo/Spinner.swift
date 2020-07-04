//
//  Spinner.swift
//  TrialTask
//
//  Created by Nikunj on 03/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) {
            spinner.style = .large
        } else {
            spinner.style = .gray
        }
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
