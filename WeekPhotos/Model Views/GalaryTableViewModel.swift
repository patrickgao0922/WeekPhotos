//
//  GalaryTableViewModel.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol GalaryTableViewModel {
//    var galariesDriver: Driver<[Galary]> {get}
    func fetchGalaries(by query:String)
}

class GalaryTableViewModelImplementation:GalaryTableViewModel {
    
    fileprivate var cellViewModels:[GalaryTableViewCellViewModel]
    fileprivate var modelLayer:ImgurModelLayer
//    fileprivate var galaries:Variable<[Galary]>
    
    fileprivate var disposeBag:DisposeBag
    
    fileprivate var cellViewModelMaker:DependencyRegistry.GalaryTableViewCellViewModleMaker
    
//    var galariesDriver: Driver<[Galary]>
    
    init(with modelLayer:ImgurModelLayer,cellViewModelMaker:@escaping DependencyRegistry.GalaryTableViewCellViewModleMaker) {
        self.modelLayer = modelLayer
//        galaries = Variable<[Galary]>([])
        cellViewModels = []
        self.cellViewModelMaker = cellViewModelMaker
        
//        Setup observables
        disposeBag = DisposeBag()
//        galariesDriver = galaries.asDriver()
    }
    
    func fetchGalaries(by query:String) {
        modelLayer.searchTopGalaries(query: query)
            .subscribe { (single) in
                switch single {
                case .success(let galaries):
                    self.cellViewModels = galaries.map({ (galary) -> GalaryTableViewCellViewModel in
                        return self.cellViewModelMaker(galary)
                    })
                case .error(_):
                    break
                }
        }.disposed(by: disposeBag)
    }
}

