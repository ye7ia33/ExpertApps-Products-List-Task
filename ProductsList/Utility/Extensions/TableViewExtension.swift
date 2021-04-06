//
//  TableViewExtension.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import UIKit
extension UITableView {
    func registerCell(nibName: String, forCellReuseIdentifier identifier: String)  {
        let cellNib = UINib(nibName: nibName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: identifier)
    }
}
