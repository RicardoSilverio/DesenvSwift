//
//  TaskDetailViewController.swift
//  RSSTaskList
//
//  Created by Usuário Convidado on 13/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var txtTarefa: UITextField!
    var managedTask:Task?
    var managedObjectContext:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(managedTask != nil) {
            txtTarefa.text = managedTask?.nome
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addTask(sender: UIBarButtonItem) {
        
        if(managedTask == nil) {
            
            let entityDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: self.managedObjectContext!)
        
            let task = Task(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
            task.nome = self.txtTarefa.text
            
        } else {
            managedTask?.nome = txtTarefa.text
        }
        
        do {
            try self.managedObjectContext!.save()
            self.navigationController!.popViewControllerAnimated(true)
        } catch {
            print("Erro ao salvar task")
        }
    }

}
