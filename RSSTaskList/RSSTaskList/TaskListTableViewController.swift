//
//  TaskListTableViewController.swift
//  RSSTaskList
//
//  Created by Usuário Convidado on 13/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UITabBarControllerDelegate {

    var managedObjectContext:NSManagedObjectContext?
    var managedTask:Task?
    var arrayStatus:[Status] = []
    var arrayTasks:[Task] = []
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    var fetchStatus: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCoreDataStack()
        self.getFetchedResultController()
    }
    
    override func viewDidAppear(animated: Bool) {
        getFetchedResultController()
        tableView.reloadData()
    }
    
    func setupCoreDataStack() {
        
        /*
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
        
        
        // Carga Inicial
        let cargaInicialExecutada = NSUserDefaults.standardUserDefaults().objectForKey("cargaInicialExecutada")
        if(cargaInicialExecutada == nil) {
            let entityDescription = NSEntityDescription.entityForName("Status", inManagedObjectContext: managedObjectContext!)
            
            do {
                
                var status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "a fazer"
                try managedObjectContext!.save()
                arrayStatus.append(status)
                
                status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "em progresso"
                try managedObjectContext!.save()
                arrayStatus.append(status)
                
                status = Status(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
                status.tipo = "completada"
                try managedObjectContext!.save()
                arrayStatus.append(status)
                
                NSUserDefaults.standardUserDefaults().setValue("S", forKey: "cargaInicialExecutada")
                NSUserDefaults.standardUserDefaults().synchronize()
                
            } catch {
                print("Erro na carga inicial")
            }
            
        } else {
            getFetchResultStatus()
        }
        */
        managedObjectContext = Setup.doSetup()
        getFetchResultStatus()
        
    }
    
    @IBAction func tapAdicionarTask(sender: UIButton) {
        performSegueWithIdentifier("taskListToDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController:TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
        detailViewController.managedObjectContext = self.managedObjectContext
        if(fetchStatus.fetchedObjects!.count > 0) {
            self.arrayStatus = fetchStatus.fetchedObjects as! [Status]
        }
        detailViewController.arrayStatus = self.arrayStatus
        if(sender is NSIndexPath) {
            let task:Task = arrayTasks[(sender as! NSIndexPath).row]
            detailViewController.managedTask = task
        }
    }
    
    func getFetchedResultController() {
        
        arrayTasks = []
        if(self.tabBarController?.selectedIndex == 1) { // Tarefas completadas
            
            let fetchRequest = NSFetchRequest(entityName: "Status")
            let sortDescriptor = NSSortDescriptor(key: "tipo", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.predicate = NSPredicate(format: "tipo like 'completada'")
            
            do {
                self.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
                self.fetchedResultController.delegate = self

                try fetchedResultController.performFetch()
                let results = try managedObjectContext!.executeFetchRequest(fetchRequest)
                for task in (results[0] as! Status).tasks! {
                    arrayTasks.append(task as! Task)
                }
            } catch {
                print("Erro ao executar fetch request das tarefas completadas")
            }
       
        
        } else { // Todas as tarefas
            
            let fetchRequest = NSFetchRequest(entityName: "Task")
            
            let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        
            self.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultController.delegate = self
        
        
            do {
                try fetchedResultController.performFetch()
                let results = try managedObjectContext!.executeFetchRequest(fetchRequest)
                for task in results {
                    arrayTasks.append(task as! Task)
                }
            } catch {
                print("Erro ao executar fetch request de todas as tasks")
            }
        }
        
    }
    
    func getFetchResultStatus() {
        let fetchRequest = NSFetchRequest(entityName: "Status")
        
        let sortDescriptor = NSSortDescriptor(key: "tipo", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self.fetchStatus = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchStatus.delegate = self
        
        do {
            try self.fetchStatus.performFetch()
        } catch {
            print("Erro ao executar fetch request de status")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellTask", forIndexPath: indexPath)
        let task = arrayTasks[indexPath.row]
        cell.textLabel?.text = task.nome
        return cell
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        if(controller == fetchedResultController) {
            arrayTasks = []
            if(fetchedResultController.fetchedObjects?.count > 0) {
                if(fetchedResultController.fetchedObjects![0] is Task) {
                    for task in fetchedResultController.fetchedObjects! {
                        arrayTasks.append(task as! Task)
                    }
                } else {
                    for task in (fetchedResultController.fetchedObjects![0] as! Status).tasks! {
                        arrayTasks.append(task as! Task)
                    }
                }
            }
            tableView.reloadData()
        } else {
            arrayStatus = []
            for status in controller.fetchedObjects! {
                arrayStatus.append(status as! Status)
            }
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let managedObject = arrayTasks[indexPath.row]
            self.managedObjectContext?.deleteObject(managedObject)
            do {
                try self.managedObjectContext?.save()
            } catch {
                print("Erro ao deletar objeto")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("taskListToDetailSegue", sender: indexPath)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
