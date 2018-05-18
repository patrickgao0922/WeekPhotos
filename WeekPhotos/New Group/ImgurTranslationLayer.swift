//
//  ImgurTranslationLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol ImgurTranslationLayer {}

class ImgurTranslationLayerImplementation:ImgurTranslationLayer {
    func translateDataIntoGalaryResponseDTO(data:Data) -> GalaryResponse? {
        return  try? JSONDecoder().decode(GalaryResponse.self, from: data)
    }
}
