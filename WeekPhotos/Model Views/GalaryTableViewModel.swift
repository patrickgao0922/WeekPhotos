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
    var galariesDriver: Driver<[Galary]> {get}
    func fetchGalaries(by query:String)
}

class GalaryTableViewModelImplementation:GalaryTableViewModel {
    
    fileprivate var cellViewModels:[GalaryTableViewCellViewModel]
    fileprivate var modelLayer:ImgurModelLayer
    fileprivate var galaries:Variable<[Galary]>
    
    fileprivate var disposeBag:DisposeBag
    
    var galariesDriver: Driver<[Galary]>
    
    init(with modelLayer:ImgurModelLayer) {
        self.modelLayer = modelLayer
        galaries = Variable<[Galary]>([])
        cellViewModels = []
        
//        Setup observables
        disposeBag = DisposeBag()
        galariesDriver = galaries.asDriver()
    }
    
    func fetchGalaries(by query:String) {
        modelLayer.searchTopGalaries(query: query)
            .subscribe { (single) in
                switch single {
                case .success(let galaries):
                    self.galaries.value = galaries
                case .error(_):
                    break
                }
        }.disposed(by: disposeBag)
    }
}

