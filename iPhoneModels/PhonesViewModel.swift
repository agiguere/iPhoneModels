//
//  PhonesViewModel.swift
//  iPhoneModels
//
//  Created by Alexandre Giguere on 2019-10-27.
//  Copyright © 2019 Alexandre Giguere. All rights reserved.
//

import Foundation
import SAPFiori

class PhonesViewModel {
    
    private var phones = Phone.getFromPropertyList() ?? []
    private var initialPhones = Phone.getFromPropertyList() ?? []
    
    init() { }
    
    var numberOfSections: Int { 1 }
    
    func numberOfRows(in section: Int) -> Int {
        phones.count
    }
    
    func configureCell(_ cell: FUIObjectTableViewCell, at indexPath: IndexPath) {
        let phone = phones[indexPath.row]
        
        cell.headlineText = phone.name
        cell.detailImage = UIImage(named: phone.imageName)
        cell.accessoryType = .disclosureIndicator
    }
    
    func applyFilter(for searchText: String) {
        if searchText.isEmpty {
            phones = initialPhones
        } else {
            phones = initialPhones.filter( {$0.name.range(of: searchText, options: .caseInsensitive) != nil })
        }
    }
}
