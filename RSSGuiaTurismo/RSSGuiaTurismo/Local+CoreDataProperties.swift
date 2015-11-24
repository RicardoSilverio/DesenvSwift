//
//  Local+CoreDataProperties.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Local {

    @NSManaged var nome: String?
    @NSManaged var endereco: String?
    @NSManaged var imagem: String?
    @NSManaged var lat: NSNumber?
    @NSManaged var long: NSNumber?

}
