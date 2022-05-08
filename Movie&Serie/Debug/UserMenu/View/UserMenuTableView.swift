//
//  File.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 20/12/21.
//

import Foundation
import UIKit

class UserMenuTableView: UITableView {

    private var itens: [Itens] = []
    weak var cellDelegate: UserMenuDelegate?
    
    func setDataSource(menuItem: ItensMenu) {
        for itens in menuItem.result {
            self.itens.append(itens)
        }
        self.reloadData()
    }
    
    func registerCell() {
        self.isScrollEnabled = false
        self.register(UserOptionViewCell.self, forCellReuseIdentifier: "UserOptionCell")
        self.delegate = self
        self.dataSource = self
    }
}

extension UserMenuTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserOptionCell", for: indexPath)
                as? UserOptionViewCell else { return UITableViewCell() }
        let item = itens[indexPath.row]
        cell.setupCell(title: item.name, icon: item.icon)
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = itens[indexPath.row]
        if item.destinationKey == "logout" {
            self.cellDelegate?.logout()
        }
        
        if item.destinationKey == "aboutUs" {
            self.cellDelegate?.aboutUs()
        }
        tableView.reloadData()
    }
}
