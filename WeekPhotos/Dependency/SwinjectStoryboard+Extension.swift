//
//  SwinjectStoryboard+Extension.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 20/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc public class func setup() {
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistry(with: defaultContainer)
        }
        
        let dependencyRegistry = AppDelegate.dependencyRegistry!
        
        
        /// Main entry of the storyboard
        func main() {
            //        Setup Dependency
            defaultContainer.storyboardInitCompleted(GalaryViewController.self) { (r, vc) in
                let vm  = r.resolve(GalaryTableViewModel.self)!
                vc.config(with: vm, cellMaker: dependencyRegistry.makeGalaryTableViewCell(for:at:with:))
            }
        }
        main()
    }
}
