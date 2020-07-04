//
//  SubCategoriesController.swift
//  TrialTask
//
//  Created by Nikunj on 03/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

enum SortingTypes: Int {
    case mostViewed
    case mostOrdered
    case mostShared

    func getTitle() -> String {
        var title = ""
        switch self {
        case .mostViewed:
            title = "Most Viewed Products"
        case .mostOrdered:
            title = "Most Ordered Products"
        case .mostShared:
            title = "Most Shared Products"
        }
        return title
    }
}

class SubCategoriesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var category: Category?
    internal var rankings = [Ranking]()
    internal var dataArray = [CategoryProduct]()
    internal var sortedDataArray = [CategoryProduct]()
    fileprivate var selectedSubCategory: CategoryProduct?
    internal var isSortSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if let selectedCategory = category, let products = selectedCategory.products {
            self.navigationItem.title = selectedCategory.name
            if !self.rankings.isEmpty {
                self.enableSortOption()
            }
            self.dataArray = products.compactMap{$0}
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToVariants" {
            let variantsVC = segue.destination as! VariantController
            variantsVC.subCategory = selectedSubCategory
        }
    }
}

// MARK: - TableView Datasource Methods
extension SubCategoriesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSortSelected {
            return sortedDataArray.isEmpty ? 0 : sortedDataArray.count
        }
        return  dataArray.isEmpty ? 0 : dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTypeCell.id) as? CardTypeCell else {
            preconditionFailure("CardTypeCell is not registered")
        }
        cell.tag = 555
        if isSortSelected {
            cell.categoryNameLabel.text = sortedDataArray[indexPath.row].name
        } else {
            cell.categoryNameLabel.text = dataArray[indexPath.row].name
        }
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - TableView Delegation
extension SubCategoriesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let variants = dataArray[indexPath.row].variants, !variants.isEmpty  {
            if isSortSelected {
                selectedSubCategory = sortedDataArray[indexPath.row]
            } else {
                selectedSubCategory = dataArray[indexPath.row]
            }
            self.performSegue(withIdentifier: "GoToVariants", sender: self)
        }
    }
}
