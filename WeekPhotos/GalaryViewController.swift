//
//  ViewController.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class GalaryViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var toggle: UISwitch!
    fileprivate var viewModel:GalaryTableViewModel!
    fileprivate var disposeBag:DisposeBag!
    
    fileprivate var cellMaker:DependencyRegistry.GalaryTableViewCellMaker!
    
    var searchController:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate  = self
        disposeBag = DisposeBag()
        
        setupUI()
        setupObservable()
        
        
    }
    
    func config(with viewModel:GalaryTableViewModel,cellMaker:@escaping DependencyRegistry.GalaryTableViewCellMaker) {
        self.cellMaker = cellMaker
        self.viewModel = viewModel
    }
    
}

extension GalaryViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModels.value[indexPath.row]
        let cell = cellMaker(tableView ,indexPath,cellViewModel)
        
        return cell
    }
}

extension GalaryViewController:UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startDownloadImagesOnScreen()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            startDownloadImagesOnScreen()
        }
    }
    func startDownloadImagesOnScreen() {
        guard let paths = tableView.indexPathsForVisibleRows else {
            return
        }
        
        viewModel.startDownloadImage(at: paths)
    }
}

// MARK: - UI
extension GalaryViewController {
    func setupUI() {
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Setup Observables
extension GalaryViewController {
    func setupObservable() {
        self.searchController.searchBar.rx.text
            .asDriver()
            .throttle(0.3)
            .drive(viewModel.query)
            .disposed(by: disposeBag)
        
        self.toggle.rx.isOn
            .asDriver()
            .drive(viewModel.toggleEnabled)
            .disposed(by: disposeBag)
        
        self.viewModel.cellViewModels.asDriver().asObservable().subscribe(onNext: { (_) in
            self.tableView.reloadData()
            self.startDownloadImagesOnScreen()
        }).disposed(by: disposeBag)
    }
}

