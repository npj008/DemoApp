//
//  CardTypeCell.swift
//  TrialTask
//
//  Created by Nikunj on 03/07/20.
//  Copyright © 2020 Nikunj Joshi. All rights reserved.
//

import UIKit

class CardTypeCell: UITableViewCell {
    
    static var id = String.init(describing: CardTypeCell.self)
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 20
            containerView.backgroundColor = UIColor.init(red: 3.0/255.0, green: 182.0/255.0, blue: 252.0/255.0, alpha: 1.0)
            containerView.layer.masksToBounds = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if tag == 555 {
            categoryNameLabel.text = ""
        } else {
            sizeLabel.text = ""
            colorLabel.text = ""
            priceLabel.text = ""
        }
    }
}
