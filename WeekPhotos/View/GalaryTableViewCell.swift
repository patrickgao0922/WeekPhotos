//
//  GalaryTableViewCell.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit

class GalaryTableViewCell: UITableViewCell {
    
    fileprivate var viewModel:GalaryTableViewCellViewModel!

    @IBOutlet var galaryImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var additionalImageCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with viewModel:GalaryTableViewCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = self.viewModel.title
//        self.additionalImageCountLabel.text = self.viewModel.additionalImageCount
    }

}
