//
//  GalaryTableViewCellViewModel.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyGif

protocol GalaryTableViewCellViewModel{
    var imageSize:CGSize {get}
    var title:String? {get}
    var dateString:String? {get}
    var additionalImageCount:Int {get}
    var image:Variable<UIImage?> {get}
    var imageType:String? {get}
    func startDownloadImage()
}

class GalaryTableViewCellViewModelImplementation:GalaryTableViewCellViewModel{
    
    fileprivate var galary:Galary
    var title:String?
    var dateString:String?
    var additionalImageCount:Int
    var imageSize:CGSize
    var imageDownloader:ImageDownloader
    var image:Variable<UIImage?>
    var imageType:String?
    
    fileprivate var needDownloadImage:Bool
    
    fileprivate var disposeBag:DisposeBag
    
    fileprivate weak var dateFormatter:DateFormatter!
    
    init(with galary:Galary,dateFormatter:DateFormatter, imageDownloader:ImageDownloader) {
        self.galary = galary
        self.dateFormatter = dateFormatter
        self.imageDownloader = imageDownloader
        self.imageType = nil
        title = galary.title
        image = Variable<UIImage?>(nil)
        
        if galary.images?[0].type != nil {
            self.imageType = galary.images![0].type
        }
        
        if let date = galary.date {
            dateString = dateFormatter.string(from: date)
        }
        
        if let imageCount = galary.images?.count {
            additionalImageCount = imageCount-1>0 ? imageCount-1 : 0
        }
        else {
            additionalImageCount = 0
            
        }
        
        self.imageSize = CGSize(width: 400, height: 300)
        if let width = galary.images?[0].width, let height = galary.images?[0].height {
            self.imageSize = CGSize(width: width, height: height)
        }
        
        disposeBag = DisposeBag()
        
        needDownloadImage = true
        
        
    }
    
    func startDownloadImage() {
        if needDownloadImage {
            needDownloadImage = false
            guard galary.images != nil && galary.images!.count != 0 , let imageURL = galary.images?[0].link else {
                return
            }
            guard let imageHash = galary.images![0].id else {
                return
            }
            imageDownloader.downloadImage(urlString: imageURL, imageHash: imageHash).subscribe { (single) in
                switch single {
                case .success(let path):
                    
                    if self.imageType != nil {
                        let url = URL(fileURLWithPath: path)
                        if let data = try? Data(contentsOf: url) {
                            if self.imageType!.contains("gif") {
                                self.image.value = UIImage(gifData: data)
                            }
                            else {
                                self.image.value = UIImage(data: data)
                            }
                        }
                        
                    } else {
                        self.image.value = UIImage(contentsOfFile: path)
                    }
                    
                case .error(_):
                    self.image.value = nil
                }
            }.disposed(by: disposeBag)
        }
        
    }
}

extension GalaryTableViewCellViewModelImplementation {
    func setupObservables() {
        
    }
}
