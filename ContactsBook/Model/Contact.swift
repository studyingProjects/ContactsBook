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

struct Contact: ContactProtocol {
    var title: String
    var phone: String
    
    
    
}
