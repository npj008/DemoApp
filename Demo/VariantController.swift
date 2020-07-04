//
//  VariantController.swift
//  TrialTask
//
//  Created by Nikunj on 03/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

class VariantController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subCategory: CategoryProduct?
    fileprivate var dataArray = [Variant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if let selectedSubCategory = subCategory, let variants = selectedSubCategory.variants {
            self.navigationItem.title = selectedSubCategory.name
            self.dataArray = variants.compactMap{$0}
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Setup Table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
    }
}

// MARK: - TableView Datasource Methods
extension VariantController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.isEmpty ? 0 : dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTypeCell.id) as? CardTypeCell else {
            preconditionFailure("CardTypeCell is not registered")
        }
        cell.tag = 666

        if let size = dataArray[indexPath.row].size {
            cell.sizeLabel.text = "Size : " +  String(size)
        }
        if let price = dataArray[indexPath.row].price {
            cell.priceLabel.text = "Price : " +  String(price)
        }
        if let color = dataArray[indexPath.row].color {
            cell.colorLabel.text = "Color : " +  color
        }
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - TableView Delegation
extension VariantController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
