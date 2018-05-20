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
    var toggleEnabled:Variable<Bool>{set get}
    var query:Variable<String?>{set get}
    
    var cellViewModels:Variable<[GalaryTableViewCellViewModel]> {get}
    func fetchGalaries(by query:String)
}

class GalaryTableViewModelImplementation:GalaryTableViewModel {
    
    //    Input
    var toggleEnabled:Variable<Bool>
    var query:Variable<String?>
    //  Output: cell view models
    var cellViewModels:Variable<[GalaryTableViewCellViewModel]>
    
    fileprivate var modelLayer:ImgurModelLayer
    
    fileprivate var disposeBag:DisposeBag
    
    fileprivate var cellViewModelMaker:DependencyRegistry.GalaryTableViewCellViewModleMaker
    
    init(with modelLayer:ImgurModelLayer,cellViewModelMaker:@escaping DependencyRegistry.GalaryTableViewCellViewModleMaker) {
        self.modelLayer = modelLayer
        cellViewModels = Variable<[GalaryTableViewCellViewModel]>([])
        self.cellViewModelMaker = cellViewModelMaker
        
        //        Setup observables
        disposeBag = DisposeBag()
        
        toggleEnabled = Variable<Bool>(false)
        query = Variable<String?>(nil)
        
        setupObservables()
    }
    
    func fetchGalaries(by query:String) {
        modelLayer.searchTopGalaries(query: query)
            .subscribe { (single) in
                switch single {
                case .success(let galaries):
                    self.cellViewModels.value = galaries.map({ (galary) -> GalaryTableViewCellViewModel in
                        return self.cellViewModelMaker(galary)
                    })
                case .error(_):
                    break
                }
            }.disposed(by: disposeBag)
    }
}

extension GalaryTableViewModelImplementation {
    func setupObservables() {
        query.asObservable().subscribe(onNext: { (query) in
            if let query = query {
                self.fetchGalaries(by: query)
            }
        }).disposed(by: disposeBag)
    }
}

