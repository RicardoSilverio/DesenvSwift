//
//  Setup.swift
//  RSSTaskList
//
//  Created by Usuário Convidado on 16/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class Setup: NSObject {
    
    private static var managedObjectContext:NSManagedObjectContext?
    
    class func doSetup() -> NSManagedObjectContext {
        if(managedObjectContext == nil) {
            setupCoreDataStack()
        }
        return managedObjectContext!
    }
    
    private class func setupCoreDataStack() {
        
        // Criação do modelo
        let modelURL:NSURL? = NSBundle.mainBundle().URLForResource("TaskListModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        
        // Criação do coordenador
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docPath:NSURL = NSURL(fileURLWithPath: paths[0])
        print(docPath.absoluteString)
        let sqlLitePath = docPath.URLByAppendingPathComponent("TaskListModel.sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: sqlLitePath, options: nil)
        } catch {
            print("Erro ao associar coordinator")
        }
        
        // Criação do contexto
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = coordinator
        
        let cargaInicialExecutada = NSUserDefaults.standardUserDefaults().objectForKey("cargaInicialExecutada")
        if(cargaInicialExecutada == nil) {
            let entityDescription = NSEntityDescription.entityForName("Status", inManagedObjectContext: managedObjectContext!)
            
            do {
                
                var status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "a fazer"
                try managedObjectContext!.save()
                
                status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "em progresso"
                try managedObjectContext!.save()
                
                status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "completada"
                try managedObjectContext!.save()
                
                NSUserDefaults.standardUserDefaults().setValue("S", forKey: "cargaInicialExecutada")
                NSUserDefaults.standardUserDefaults().synchronize()
                
            } catch {
                print("Erro na carga inicial")
            }
            
        }
    }

}
