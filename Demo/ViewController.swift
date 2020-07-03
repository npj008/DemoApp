//
//  ViewController.swift
//  Demo
//
//  Created by Nikunj Joshi on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    fileprivate func getData() {
        APIService.shared.fetchData { [weak self] (result) in
            DispatchQueue.main.async {
                self?.handleAuthenticationResult(result)
            }
        }
    }

    fileprivate func handleAuthenticationResult(_ result: TrialTaskAPIServiceResult<DataResponse>) {
        switch result {
        case .success(let data):
            print("successful fetch")
            break
        case .failure(let error):
            print("\(error.localizedDescription)")
            break
        }
    }


}
