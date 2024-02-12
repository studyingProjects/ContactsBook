//
//  Contact.swift
//  ContactsBook
//
//  Created by Andrei Shpartou on 11/02/2024.
//

import Foundation

protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

protocol ContactStorageProtocol {
    func load() -> [ContactProtocol]
    func save(contacts: [ContactProtocol])
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}

class ContactStorage: ContactStorageProtocol {
    // Ссылка на хранилище
    private var storage = UserDefaults.standard
    // Ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"
    // Перечисление с ключами для записи в User Defaults
    private enum ContactKey: String {
        case title
        case phone
    }
    
    func load() -> [ContactProtocol] {
        var resultContacts: [ContactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue],
                  let phone = contact[ContactKey.phone.rawValue] else {
                continue
            }
            resultContacts.append(Contact(title: title, phone: phone))
        }
        return resultContacts
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayForStorage: [[String:String]] = [] 
        contacts.forEach { contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
    
}
