//
//  ViewController.swift
//  Demo
//
//  Created by Nikunj Joshi on 02/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate var categories = [Category]()
    fileprivate var dataArray = [String]()
    internal var rankings = [Ranking]()
    fileprivate var productIds = [Int]()
    fileprivate var selectedCategory: Category?
    fileprivate var childCategoriesAvailable: Bool = false
    fileprivate var childCategories = [Category]()
    fileprivate let spinner = SpinnerViewController()
    fileprivate var selectedRowIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getData()
        self.navigationItem.title = "Products"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if childCategoriesAvailable {
            childCategoriesAvailable = false
            childCategories.removeAll()
            self.tableView.reloadSections([selectedRowIndex], with: .fade)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup Table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
    }
    
    // MARK: - Fetch data
    fileprivate func getData() {
        createSpinnerView()
        APIService.shared.fetchData { [weak self] (result) in
        self?.dismissSpinnerView()
            DispatchQueue.main.async {
                self?.handleAuthenticationResult(result)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSubcategories" {
            let subCategoriesVC = segue.destination as! SubCategoriesController
            subCategoriesVC.category = selectedCategory
            subCategoriesVC.rankings = rankings
        }
    }
    
    // MARK: - Load data
    fileprivate func handleAuthenticationResult(_ result: TrialTaskAPIServiceResult<Bool>) {
        switch result {
        case .success(_ ):
            print("successful fetch")
            do {
                let data = try UserDefaultHelper.getObject(forKey: "MyData", castTo: DataResponse.self)
                self.dataArray = data.categories?.compactMap{$0.name!} ?? []
                self.categories = data.categories ?? []
                self.rankings = data.rankings ?? []
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            break
        case .failure(let error):
            print("\(error.localizedDescription)")
            break
        }
    }
    
    // MARK: - Add the spinner view
    fileprivate func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }

    // MARK: - Remove the spinner view
    fileprivate func dismissSpinnerView() {
        DispatchQueue.main.async {
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
}

// MARK: - TableView Datasource Methods
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.isEmpty ? 0 : categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childCategoriesAvailable && section == selectedRowIndex ? childCategories.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !childCategoriesAvailable && indexPath.section != selectedRowIndex {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTypeCell.id) as? CardTypeCell else {
            preconditionFailure("CardTypeCell is not registered")
        }
        cell.selectionStyle = .none
        cell.tag = 555
        if childCategoriesAvailable {
            cell.categoryNameLabel.text = childCategories[indexPath.row].name
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        viewHeader.backgroundColor = .clear
        let button = UIButton(type: .custom)
        button.tag = section
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        button.setTitle(categories[section].name, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        viewHeader.addSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.leadingAnchor.constraint(equalTo: viewHeader.leadingAnchor, constant: 10),
                button.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -10),
                button.topAnchor.constraint(equalTo: viewHeader.topAnchor, constant: 5),
                button.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: -5)
            ]
        )
        
        return viewHeader
    }
    
    @objc func tapSection(sender: UIButton) {
        if let products = categories[sender.tag].products, !products.isEmpty {
            selectedCategory = categories[sender.tag]
            self.performSegue(withIdentifier: "GoToSubcategories", sender: self)
        } else if let childcategories = categories[sender.tag].childCategories, !childcategories.isEmpty {
            
            if selectedRowIndex == sender.tag {
                childCategoriesAvailable = !childCategoriesAvailable
            } else {
                if childCategoriesAvailable {
                    childCategoriesAvailable = false
                    self.tableView.reloadSections([selectedRowIndex], with: .fade)
                }
                childCategoriesAvailable = true
                selectedRowIndex = sender.tag
            }
            childCategories.removeAll()
            if childCategoriesAvailable {
                childCategories = categories.filter {childcategories.contains($0.categoryId as! Int)}
            }
            self.tableView.reloadSections([sender.tag], with: .fade)
            scrollToRow(section: selectedRowIndex)
        }
    }
    
    private func scrollToRow(section: Int) {
        if !childCategories.isEmpty {
            self.tableView.scrollToRow(
                at: IndexPath(row: childCategories.count - 1, section: section),
                at: .bottom,
                animated: true
            )
        }
    }
}

// MARK: - TableView Delegation
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if childCategoriesAvailable && indexPath.section == selectedRowIndex{
            return 70
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let products = childCategories[indexPath.row].products, !products.isEmpty {
            selectedCategory = childCategories[indexPath.row]
            self.performSegue(withIdentifier: "GoToSubcategories", sender: self)
        }
    }
}


