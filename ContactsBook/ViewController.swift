//
//  ViewController.swift
//  ContactsBook
//
//  Created by Andrei Shpartou on 11/02/2024.
//

import UIKit

class ViewController: UIViewController {

    private var contacts = [ContactProtocol]() {
        didSet {
            contacts.sort{ $0.title < $1.title}
        }
    }
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadContacts()
    }
    
    private func loadContacts() {
        contacts.append(Contact(title: "Sana TO", phone: "+78885545"))
        contacts.append(Contact(title: "Voloda garaj", phone: "+78885545"))
        contacts.append(Contact(title: "Silvestr", phone: "+375445557575"))
    }
    
    @IBAction private func showNewContactAlert() {
        let alert = UIAlertController(title: "Creating a new contact", message: "Fill in the name and phone", 
                                      preferredStyle: .alert)
        alert.addTextField {textField in
            textField.placeholder = "Name"
        }
        alert.addTextField {textField in
            textField.placeholder = "Phone number"
        }
        
        let createButton = UIAlertAction(title: "Create", style: .default) {_ in
            guard let contactName = alert.textFields?[0].text,
                  let phoneNumber = alert.textFields?[1].text else {
                return
            }
            // create a new contact
            let contact = Contact(title: contactName, phone: phoneNumber)
            self.contacts.append(contact)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(createButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
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
        configuration.text = contacts[indexPath.row].title
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
        
//        if #available(iOS 14, *) {
//        var configuration = cell.defaultContentConfiguration() configuration.text = "Строка \(indexPath.row)" cell.contentConfiguration = configuration
//        }
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete", handler: {_,_,_ in 
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        })
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
