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
    fileprivate var imageId:String?
    fileprivate var imageLink:String?
    
    fileprivate var needDownloadImage:Bool
    
    fileprivate var disposeBag:DisposeBag
    
    fileprivate weak var dateFormatter:DateFormatter!
    
    init(with galary:Galary,dateFormatter:DateFormatter, imageDownloader:ImageDownloader) {
        self.galary = galary
        self.dateFormatter = dateFormatter
        self.imageDownloader = imageDownloader
        
        //        Initially setup properties
        self.imageLink = nil
        self.imageId = nil
        self.imageType = nil
        title = galary.title
        image = Variable<UIImage?>(nil)
        self.additionalImageCount = 0
        self.imageSize = CGSize(width: 400, height: 300)
        
        //        set up properties for galary entity
        
        if let date = galary.date {
            dateString = dateFormatter.string(from: date)
        }
        
        //        For galary that has image list
        if let images = galary.images,images.count != 0 {
            
            let firstImage = images[0]
            if firstImage.type != nil {
                self.imageType = firstImage.type
            }
            
            additionalImageCount = images.count-1
            
            if let width = firstImage.width, let height = firstImage.height {
                self.imageSize = CGSize(width: width, height: height)
            }
            
            if let link = firstImage.link {
                self.imageLink = link
                
                
            }

            self.imageId = firstImage.id
        } else if let imageType = self.galary.type {
            self.imageType = imageType
            
            if let width = self.galary.width ,let height = self.galary.height {
                self.imageSize = CGSize(width: width, height: height)
            }
            if let link = self.galary.link {
                
                self.imageLink = link
                self.imageId = self.galary.id
            }
            
        }
        
        disposeBag = DisposeBag()
        
        needDownloadImage = true
        
        
    }
    
    func startDownloadImage() {
        
        if image.value == nil {
            guard let link = imageLink else {
                needDownloadImage = false
                return
            }
            guard let imageHash = self.imageId else {
                needDownloadImage = false
                return
            }

            if needDownloadImage {
                
                let imagePath = imageDownloader.buildImagePath(imageHash: imageHash)
                if imageDownloader.imageExists(imagePath: imagePath) {
                    //                if let data = try? Data(contentsOf: imagePath) {
                    if let imageType = self.imageType, imageType.contains("gif") {
                        if let data = try? Data(contentsOf: imagePath) {
                            self.image.value = UIImage(gifData: data)
                            needDownloadImage = false
                            return
                        }
                    } else {
                        self.image.value = UIImage(contentsOfFile: imagePath.path)
                        needDownloadImage = false
                        return
                    }
                    
                }

                imageDownloader.downloadImage(urlString: link, imageHash: imageHash).subscribe { (single) in
                    switch single {
                    case .success(let path):
                        
                        if let imageType = self.imageType, imageType.contains("gif") {
                            let url = URL(fileURLWithPath: path)
                            if let data = try? Data(contentsOf: url) {
                                self.image.value = UIImage(gifData: data)
                            } else {
                                print("error")
                            }
                        } else {
                            self.image.value = UIImage(contentsOfFile: path)
                        }
                        self.needDownloadImage = false
                        
                    case .error(_):
                        self.image.value = nil
                    }
                    }.disposed(by: disposeBag)
            }
        }
        
    }
}
