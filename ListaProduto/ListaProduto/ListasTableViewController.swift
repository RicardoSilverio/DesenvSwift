//
//  ListasTableViewController.swift
//  ListaProduto
//
//  Created by Ricardo Silverio de Souza on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class ListasTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchedResultController: NSFetchedResultsController?
    var managedObjectContext:NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.managedObjectContext = Setup.getManagedObjectContext()
        
        let fetchRequest = NSFetchRequest(entityName: "Lista")
        
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        self.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultController?.delegate = self
        
        
        do {
            try fetchedResultController!.performFetch()
        } catch {
            print("Erro ao recuperar listas")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultController?.fetchedObjects != nil && fetchedResultController?.fetchedObjects?.count > 0 ? 1 : 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.fetchedResultController?.fetchedObjects!.count)!
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellLista", forIndexPath: indexPath)
        let lista = self.fetchedResultController?.objectAtIndexPath(indexPath) as! Lista
        cell.textLabel?.text = lista.nome
        return cell
    }

    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController = segue.destinationViewController as! ListaDetailTableViewController
        if(sender is NSIndexPath) {
            let indexPath = sender as! NSIndexPath
            let lista = fetchedResultController?.objectAtIndexPath(indexPath) as! Lista
            detailViewController.lista = lista
        }
        detailViewController.managedObjectContext = self.managedObjectContext
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("tableToDetailSegue", sender: indexPath)
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            do {
                let lista = fetchedResultController?.objectAtIndexPath(indexPath)
                managedObjectContext?.delete(lista)
                try managedObjectContext?.save()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } catch {
                print("Erro ao deletar lista")
            }
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func tapAdicionarLista(sender: UIBarButtonItem) {
        performSegueWithIdentifier("tableToDetailSegue", sender: self)
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
