//
//  DependencyRegistry.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Swinject

class DependencyRegistry {
    var container:Container
    
    init(with container:Container) {
        self.container = container
        registerDependencies()
        registerViewModels()
    }
    
    func registerDependencies() {
        container.register(ImgurNetworkLayer.self) { (r) in
            ImgurNetworkLayerImplementation()
        }
        
        container.register(ImgurTranslationLayer.self) { (r) in
            ImgurTranslationLayerImplementation()
        }
        
        container.register(ImgurModelLayer.self) { (r) in
            ImgurModelLayerImplementation(with: r.resolve(ImgurNetworkLayer.self)!, translationLayer: r.resolve(ImgurTranslationLayer.self)!)
        }
    }
    
    func registerViewModels() {
        container.register(GalaryTableViewModel.self) { (r) in
            GalaryTableViewModelImplementation(with: r.resolve(ImgurModelLayer.self)!)
        }
    }
}
