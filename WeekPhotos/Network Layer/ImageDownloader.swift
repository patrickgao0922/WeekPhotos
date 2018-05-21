//
//  ImageDownloader.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 20/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import Alamofire

protocol ImageDownloader {
    func buildImagePath(imageHash:String) -> URL
    func imageExists(imagePath:URL) -> Bool
    func downloadImage(urlString:String,imageHash:String) -> Single<String>
}

enum HTTPError:Error{
    case noResultData
    case jsonParsingError
    case imageParsingError
}

class ImageDownloaderImplementation:ImageDownloader {
    let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    /// Download image and return the location of the image where it is stored
    ///
    /// - Parameter url: image url string
    /// - Returns: image stored location path
    func downloadImage(urlString:String,imageHash:String) -> Single<String> {
        
        let url = URL(string: urlString)!
        return downloadImage(from: url, imageHash: imageHash)
    }
    
    fileprivate func downloadImage(from url:URL, imageHash:String) -> Single<String>{
        return Single<String>.create(subscribe: { (single) -> Disposable in

            let fileURL = self.buildImagePath(imageHash: imageHash)
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            //            if self.imageExists(fileURL: fileURL){
            //                single(.success(fileURL.path))
            //            }else {
            
            
            download(url, method: .get, to:destination)
                .responseData(queue: self.dispatchQueue,completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let value):
                        guard UIImage(data: value) != nil else {
                            return single(.error(HTTPError.imageParsingError))
                        }
                        guard let imagePath = response.destinationURL?.path else {
                            return single(.error(HTTPError.noResultData))
                        }
                        single(.success(imagePath))
                    case .failure(let error):
                        single(.error(error))
                    }
                    
                })
            
            
            //            }
            
            return Disposables.create()
        })
    }
    
    func buildImagePath(imageHash:String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("image").appendingPathComponent(imageHash)
        return fileURL
    }
    func imageExists(imagePath:URL) -> Bool {
        return FileManager.default.fileExists(atPath: imagePath.path)
    }
}
