//
//  ImgurTranslationLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol ImgurTranslationLayer {
    func translateDataIntoGalaryResponseDTO(data:Data) -> GalaryResponse?
    func translateDataIntoImageResponseDTO(data:Data) -> ImageResponse?
}

class ImgurTranslationLayerImplementation:ImgurTranslationLayer {
    fileprivate var jsonDecoder:JSONDecoder!
    init(){
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
    }
    func translateDataIntoGalaryResponseDTO(data:Data) -> GalaryResponse? {
        do {
            return try jsonDecoder.decode(GalaryResponse.self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func translateDataIntoImageResponseDTO(data:Data) -> ImageResponse? {
        do {
            return try jsonDecoder.decode(ImageResponse.self, from: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
