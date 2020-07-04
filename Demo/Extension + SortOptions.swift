//
//  Extension + SortOptions.swift
//  TrialTask
//
//  Created by Nikunj on 03/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

extension SubCategoriesController {
     // MARK: - Enable sort option
    func enableSortOption() {
         self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Sort", style: .done, target: self, action: #selector(sortProducts))
     }
    
    // MARK: - Sort according to the selected rank
    @objc private func sortProducts() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let _ = rankings[0].ranking {
            let viewdButton = UIAlertAction(title: SortingTypes.mostViewed.getTitle(), style: .default, handler: { _ in
                self.reloadTableData(sortIndex: SortingTypes.mostViewed.rawValue)
            })
            alertController.addAction(viewdButton)
        }
        
        if let _ = rankings[1].ranking {
            let orderdButton = UIAlertAction(title: SortingTypes.mostOrdered.getTitle(), style: .default, handler: { _ in
                self.reloadTableData(sortIndex: SortingTypes.mostOrdered.rawValue)
            })
            alertController.addAction(orderdButton)
        }
        
        if let _ = rankings[2].ranking {
            let sharedButton = UIAlertAction(title: SortingTypes.mostShared.getTitle(), style: .default, handler: { _ in
                self.reloadTableData(sortIndex: SortingTypes.mostShared.rawValue)
            })
            alertController.addAction(sharedButton)
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func reloadTableData(sortIndex: Int) {
        if let rankedproducts = rankings[sortIndex].products?.compactMap({$0.id}) {
            isSortSelected = true
            sortedDataArray = dataArray.filter {rankedproducts.contains($0.id ?? 0)}
            tableView.reloadData()
        }
    }
}
