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
    @IBOutlet weak var segStatus: UISegmentedControl!
    
    var managedTask:Task?
    var arrayStatus:[Status] = []
    var managedObjectContext:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(managedTask != nil) {
            txtTarefa.text = managedTask?.nome
            segStatus.selectedSegmentIndex = (managedTask!.status!.tipo == "em progresso") ? 2 : (managedTask!.status!.tipo == "completada") ? 1 : 0
        } else {
            segStatus.selectedSegmentIndex = 0
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
            task.status = arrayStatus[segStatus.selectedSegmentIndex]
            
        } else {
            managedTask?.nome = txtTarefa.text
            managedTask?.status = arrayStatus[segStatus.selectedSegmentIndex]
        }
        
        do {
            try self.managedObjectContext!.save()
            self.navigationController!.popViewControllerAnimated(true)
        } catch {
            print("Erro ao salvar task")
        }
    }

}
