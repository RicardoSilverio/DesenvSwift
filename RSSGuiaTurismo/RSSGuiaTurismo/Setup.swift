//
//  Setup.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class Setup: NSObject {
    
    private static var managedObjectContext:NSManagedObjectContext?
    
    class func getManagedObjectContext() -> NSManagedObjectContext {
        if(managedObjectContext == nil) {
            setupCoreDataStack()
        }
        return managedObjectContext!
    }
    
    private class func setupCoreDataStack() {
        
        // Criação do modelo
        let modelURL:NSURL? = NSBundle.mainBundle().URLForResource("GuiaTurismoModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        
        // Criação do coordenador
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath:NSURL = NSURL(fileURLWithPath: paths[0])
        print(docPath.absoluteString)
        let sqlLitePath = docPath.URLByAppendingPathComponent("GuiaTurismoModel.sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: sqlLitePath, options: nil)
        } catch {
            print("Erro ao associar coordinator")
        }
        
        // Criação do contexto
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        self.managedObjectContext!.persistentStoreCoordinator = coordinator

    }
    
}

