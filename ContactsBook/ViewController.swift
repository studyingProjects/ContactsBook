//
//  ViewController.swift
//  ContactsBook
//
//  Created by Andrei Shpartou on 11/02/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let reuseCell = tableView .dequeueReusableCell(withIdentifier: "contactCellIdentifier") {
            print("Используем старую ячейку для строки с индексом \(indexPath.row)")
            cell = reuseCell
        } else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "contactCellIdentifier")
        }
        configure(cell: &cell, indexPath: indexPath)
        
        return cell
    }
        
    func configure(cell: inout UITableViewCell, indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "String \(indexPath.row)"
        cell.contentConfiguration = configuration
//        if #available(iOS 14, *) {
//        var configuration = cell.defaultContentConfiguration() configuration.text = "Строка \(indexPath.row)" cell.contentConfiguration = configuration
//        }
    }
    
    
}
