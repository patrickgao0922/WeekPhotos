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
    
    private func registerDependencies() {
        container.register(ImgurNetworkLayer.self) { (r) in
            ImgurNetworkLayerImplementation()
        }.inObjectScope(.container)
        
        container.register(ImgurTranslationLayer.self) { (r) in
            ImgurTranslationLayerImplementation()
        }.inObjectScope(.container)
        
        container.register(ImgurModelLayer.self) { (r) in
            ImgurModelLayerImplementation(with: r.resolve(ImgurNetworkLayer.self)!, translationLayer: r.resolve(ImgurTranslationLayer.self)!)
        }.inObjectScope(.container)
        
        container.register(ImageDownloader.self) { (r) in
            ImageDownloaderImplementation()
            }
    }
    
    private func registerViewModels() {
        container.register(GalaryTableViewModel.self) { (r) in
            GalaryTableViewModelImplementation(with: r.resolve(ImgurModelLayer.self)!,cellViewModelMaker:self.makeGalaryTableViewCellViewModel(with:dateFormatter:))
        }.inObjectScope(.container)
        
        
        container.register(GalaryTableViewCellViewModel.self) { (r, galary, dateFormatter)  in
            GalaryTableViewCellViewModelImplementation(with: galary, dateFormatter: dateFormatter, imageDownloader: r.resolve(ImageDownloader.self)!)
        }.inObjectScope(.transient)
    }
}

// Factory Methods
extension DependencyRegistry {
    
    /// Cell view model maker function
    typealias GalaryTableViewCellViewModleMaker = (Galary,DateFormatter) -> GalaryTableViewCellViewModel
    func makeGalaryTableViewCellViewModel(with galary:Galary,dateFormatter:DateFormatter) -> GalaryTableViewCellViewModel {
//        return container.resolve(GalaryTableViewCellViewModel.self, argument: galary)!
        return container.resolve(GalaryTableViewCellViewModel.self, arguments: galary, dateFormatter)!
    }
    
    /// Table view cell maker function
    typealias  GalaryTableViewCellMaker = (UITableView,IndexPath,GalaryTableViewCellViewModel) -> GalaryTableViewCell
    func makeGalaryTableViewCell(for tableView:UITableView, at indexPath:IndexPath, with cellViewModel:GalaryTableViewCellViewModel) -> GalaryTableViewCell{
        let cellIdentifier = "galaryCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GalaryTableViewCell
        cell.config(with: cellViewModel)
        
        return cell
    }
    
}
