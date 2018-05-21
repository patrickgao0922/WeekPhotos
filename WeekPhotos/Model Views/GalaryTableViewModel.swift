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
    func startDownloadImage(at paths: [IndexPath])
}

class GalaryTableViewModelImplementation:GalaryTableViewModel {
    
    //    Input
    var toggleEnabled:Variable<Bool>
    var query:Variable<String?>
    //  Output: cell view models
    var cellViewModels:Variable<[GalaryTableViewCellViewModel]>
    
    fileprivate var galaries:Variable<[Galary]>
    fileprivate var modelLayer:ImgurModelLayer
    fileprivate var disposeBag:DisposeBag
    
//    date formatter that will be used by cell view model
    fileprivate var dateFormatter:DateFormatter
    
    fileprivate var cellViewModelMaker:DependencyRegistry.GalaryTableViewCellViewModleMaker
    
    init(with modelLayer:ImgurModelLayer,cellViewModelMaker:@escaping DependencyRegistry.GalaryTableViewCellViewModleMaker) {
        self.modelLayer = modelLayer
        cellViewModels = Variable<[GalaryTableViewCellViewModel]>([])
        galaries = Variable<[Galary]>([])
        self.cellViewModelMaker = cellViewModelMaker
        
        //        Setup observables
        disposeBag = DisposeBag()
        
        toggleEnabled = Variable<Bool>(false)
        query = Variable<String?>(nil)
        
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/MM/yyyy h:mm:ss a"
        
        setupObservables()
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
    
    func startDownloadImage(at paths: [IndexPath]) {
        for indexPath in paths {
            cellViewModels.value[indexPath.row].startDownloadImage()
        }
    }
}

extension GalaryTableViewModelImplementation {
    func setupObservables() {
        query.asObservable().subscribe(onNext: { (query) in
            if let query = query {
                self.fetchGalaries(by: query)
            }
        }).disposed(by: disposeBag)
        
//        Combine galaries and toggle observable
        Observable.combineLatest(galaries.asObservable(), toggleEnabled.asObservable()) { (galaries, toggleEnabled) -> (galaries:[Galary],toggleEnabled:Bool) in
            return (galaries,toggleEnabled)
        }
            .subscribe(onNext: { (result) in
                let galaries = result.galaries
                let toggleEnabled = result.toggleEnabled
                
                self.cellViewModels.value = galaries
                    .filter({ (galary) -> Bool in
                        if toggleEnabled {
                            var sum = 0
                            if let points = galary.points {
                                sum += points
                            }
                            if let topicId = galary.topicId {
                                sum += topicId
                            }
                            
                            if let score = galary.score {
                                sum += score
                            }
                            return sum%2 == 0
                        } else {
                            return true
                        }
                    })
                    .sorted(by: { (first, second) -> Bool in
                        if first.date == nil {
                            return false
                        }
                        if second.date == nil {
                            return true
                        }
                        return first.date!>second.date!
                    })
                    .map({ (galary) -> GalaryTableViewCellViewModel in
                        
                        return self.cellViewModelMaker(galary,self.dateFormatter)
                    })
            }).disposed(by: disposeBag)
    }
}

