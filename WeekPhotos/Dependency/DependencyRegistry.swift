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
    }
    
    func registerDependencies() {
        container.register(ImgurNetworkLayer.self) { (r) in
            ImgurNetworkLayerImplementation()
        }
        
        container.register(ImgurTranslationLayer.self) { (r) in
            ImgurTranslationLayerImplementation()
        }
        
        container.register(ImgurModelLayer.self) { (r) in
            ImgurModelLayerImplementation()
        }
    }
}
