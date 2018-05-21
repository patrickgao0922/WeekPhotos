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
    func downloadImage(urlString:String,imageHash:String) -> Single<String>
}

enum HTTPError:Error{
    case noResultData
    case jsonParsingError
    case imageParsingError
}

class ImageDownloaderImplementation:ImageDownloader {
    let dispatchQueue = DispatchQueue(label: "com.patrickgao.WeekPhotos")
    /// Download image and return the location of the image where it is stored
    ///
    /// - Parameter url: image url string
    /// - Returns: image stored location path
    func downloadImage(urlString:String,imageHash:String) -> Single<String> {
        
        let url = URL(string: urlString)!
        return downloadImage(from: url, filename: imageHash)
    }
    
    fileprivate func downloadImage(from url:URL, filename:String) -> Single<String>{
        return Single<String>.create(subscribe: { (single) -> Disposable in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image").appendingPathComponent(filename)
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            if self.imageExists(fileURL: fileURL){
                single(.success(fileURL.path))
            }else {
                
                self.dispatchQueue.async {
                    download(url, method: .get, to:destination)
                        .responseData(completionHandler: { (response) in
                            
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
                }
                
            }
            
            return Disposables.create()
        })
    }
    fileprivate func imageExists(fileURL:URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.absoluteString)
    }
}
