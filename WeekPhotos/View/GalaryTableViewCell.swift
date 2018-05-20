//
//  GalaryTableViewCell.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift

class GalaryTableViewCell: UITableViewCell {
    
    fileprivate var viewModel:GalaryTableViewCellViewModel!

    @IBOutlet var galaryImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var additionalImageCountLabel: UILabel!
    fileprivate var disposeBag:DisposeBag!
    
    fileprivate var imageDownloadSub:Disposable?
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
        imageDownloadSub?.dispose()
        self.titleLabel.text = self.viewModel.title
        self.dateLabel.text = self.viewModel.dateString
        disposeBag = DisposeBag()
//        self.additionalImageCountLabel.text = self.viewModel.additionalImageCount
        self.galaryImageView.image = nil
        if viewModel.additionalImageCount != 0 {
            additionalImageCountLabel.isHidden = false
            additionalImageCountLabel.text = "\(viewModel.additionalImageCount) more images"
        } else {
            additionalImageCountLabel.isHidden = true
        }
        
       self.applyImageSizeConstraints(size: viewModel.imageSize)
        setupObservables()
    }
    
    fileprivate func applyImageSizeConstraints(size:CGSize) {
        let width = self.bounds.size.width
        
        let factor = size.width / width
        
        let height = size.height / factor
        
        galaryImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        galaryImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
    }
    
    func startDownloadImage() {
        viewModel.startDownloadImage()
    }

}

extension GalaryTableViewCell {
    func setupObservables() {
        imageDownloadSub = viewModel.image.asDriver().asObservable().subscribe(onNext: { (image) in
            self.galaryImageView.image = image
        })
        
        imageDownloadSub?.disposed(by: disposeBag)
        
    }
}
