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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    
    }
    
    func config(with viewModel:GalaryTableViewModel) {
        self.viewModel = viewModel
    }

}

