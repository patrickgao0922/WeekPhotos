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
    fileprivate var container:Container
    
    init(with container:Container) {
        self.container = container
        registerDependencies()
        registerViewModels()
    }
    
    private func registerDependencies() {
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
    
    private func registerViewModels() {
        container.register(GalaryTableViewModel.self) { (r) in
            GalaryTableViewModelImplementation(with: r.resolve(ImgurModelLayer.self)!,cellViewModelMaker:self.makeGalaryTableViewCellViewModel(with:))
        }
        
//        Galary table view cell view model
        container.register(GalaryTableViewCellViewModel.self) { (r, galary) in
            GalaryTableViewCellViewModelImplementation(with: galary)
        }
    }
}

// Factory Methods
extension DependencyRegistry {
    
    typealias GalaryTableViewCellViewModleMaker = (Galary) -> GalaryTableViewCellViewModel
    func makeGalaryTableViewCellViewModel(with galary:Galary) -> GalaryTableViewCellViewModel {
        return container.resolve(GalaryTableViewCellViewModel.self, argument: galary)!
    }
    
    func makeGalaryTableViewCell(for tableView:UITableView, at indexPath:IndexPath, with cellViewModel:GalaryTableViewCellViewModel) -> GalaryTableViewCell{
        let cellIdentifier = "galaryCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GalaryTableViewCell
        cell.config(with: cellViewModel)
        
        return cell
    }
}
