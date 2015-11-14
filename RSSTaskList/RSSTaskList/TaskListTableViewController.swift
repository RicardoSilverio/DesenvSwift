//
//  TaskListTableViewController.swift
//  RSSTaskList
//
//  Created by Usuário Convidado on 13/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext:NSManagedObjectContext?
    var managedTask:Task?
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCoreDataStack()
        self.getFetchedResultController()
    }
    
    func setupCoreDataStack() {
        
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
    }
    
    @IBAction func tapAdicionarTask(sender: UIButton) {
        performSegueWithIdentifier("taskListToDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController:TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
        detailViewController.managedObjectContext = self.managedObjectContext
        if(sender is NSIndexPath) {
            let task:Task = fetchedResultController.objectAtIndexPath(sender as! NSIndexPath) as! Task
            detailViewController.managedTask = task
        }
    }
    
    func getFetchedResultController() {
        
        let fetchRequest = NSFetchRequest(entityName: "Task")
        
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultController.delegate = self
        
        
        do {
            try self.fetchedResultController.performFetch()
        } catch {
            print("Erro ao executar fetch request")
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
        if let count = self.fetchedResultController.fetchedObjects?.count {
            return count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellTask", forIndexPath: indexPath)
        let task = self.fetchedResultController.fetchedObjects![indexPath.row] as! Task
        cell.textLabel?.text = task.nome
        return cell
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
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
            let managedObject = fetchedResultController.objectAtIndexPath(indexPath)
            self.managedObjectContext?.deleteObject(managedObject as! NSManagedObject)
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
