//
//  PhonesTableViewController.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import UIKit
import SAPFiori

class PhonesTableViewController: UITableViewController {
    
    private let viewModel = PhonesViewModel()
    private let searchController = FUISearchController(searchResultsController: nil)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
        
        configureSearchController()
        
        configureNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FUIObjectTableViewCell
        
        viewModel.configureCell(cell, at: indexPath)
        
        return cell
    }
}

// MARK: - Private API
private extension PhonesTableViewController {
    
    func configureTableView() {
        tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)
        tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
    }
    
    func configureNavigationBar() {
        let filterImage = FUIIconLibrary.system.filter.withRenderingMode(.alwaysTemplate)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(displayFilters(_:)))
    }
    
    func configureSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.isBarcodeScannerEnabled = true
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
    }
    
    @objc func displayFilters(_ sender: UIBarButtonItem) {
        
    }
}

// MARK: - UISearchControllerDelegate
extension PhonesTableViewController: UISearchControllerDelegate { }

// MARK: - UISearchResultsUpdating
extension PhonesTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.applyFilter(for: searchText)

        tableView.reloadData()
//
//        updateTableView()
    }
}

// MARK: - UISearchControllerDelegate
extension PhonesTableViewController: UISearchBarDelegate {
    
}
