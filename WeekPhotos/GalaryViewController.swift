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
    @IBOutlet var toggle: UIBarButtonItem!
    fileprivate var viewModel:GalaryTableViewModel!
    fileprivate var disposeBag:DisposeBag!
    
    fileprivate var cellMaker:DependencyRegistry.GalaryTableViewCellMaker!
    
    var searchController:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate  = self
        setupUI()
//        setupObservable()
        
    
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
        self.searchController.searchBar.rx.text.asDriver().drive(viewModel.query)
    }
}

