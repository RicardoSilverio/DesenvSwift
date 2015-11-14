//
//  Task+CoreDataProperties.swift
//  RSSTaskList
//
//  Created by Usuário Convidado on 13/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var nome: String?
    @NSManaged var status: Status?

}
