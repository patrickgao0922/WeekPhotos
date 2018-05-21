//
//  GalaryTableViewCell.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyGif

class GalaryTableViewCell: UITableViewCell {
    
    fileprivate var viewModel:GalaryTableViewCellViewModel!
    
    
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
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
        disposeBag = DisposeBag()
        
        // Reset necessary properties before reuse the cell
        imageHeightConstraint.constant = 0
        imageDownloadSub?.dispose()
        let gifManager = SwiftyGifManager.defaultManager
        gifManager.deleteImageView(galaryImageView)
        self.galaryImageView.image = nil
        
        // Config cell
        self.titleLabel.text = self.viewModel.title
        self.dateLabel.text = self.viewModel.dateString

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
 
        imageHeightConstraint.constant = height
        self.layoutIfNeeded()
    }
    
    func startDownloadImage() {
        viewModel.startDownloadImage()
    }
    
}

// MARK: - Setup Observables
extension GalaryTableViewCell {
    func setupObservables() {
        
//        Listen image changes
        imageDownloadSub = viewModel.image.asDriver().asObservable().subscribe(onNext: { (image) in
            if let imageType = self.viewModel.imageType,imageType.contains("gif") {
                if let image = image {
                    self.galaryImageView.setGifImage(image)
                }
            } else {
                self.galaryImageView.image = image
            }
        })
        imageDownloadSub?.disposed(by: disposeBag)
        
    }
}
