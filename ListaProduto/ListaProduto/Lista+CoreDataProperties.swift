//
//  Lista+CoreDataProperties.swift
//  ListaProduto
//
//  Created by Ricardo Silverio de Souza on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lista {

    @NSManaged var nome: String?
    @NSManaged var produtos: NSSet?

}
