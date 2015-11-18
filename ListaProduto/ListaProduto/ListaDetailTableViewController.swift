//
//  ListaDetailTableViewController.swift
//  ListaProduto
//
//  Created by Ricardo Silverio de Souza on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import CoreData

class ListaDetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var managedObjectContext:NSManagedObjectContext?
    
    var lista:Lista?
    var produtos:[String?!] = []
    
    @IBOutlet weak var txtNomeLista: UITextField!
    @IBOutlet weak var txtNomeProduto: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if(lista != nil) {
            txtNomeLista.text = lista?.nome
            if(lista?.produtos != nil) {
                for produto in (lista?.produtos)! {
                    self.produtos.append(produto.nome)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return produtos.count != 0 ? 1 : 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return produtos.count
    }
    
    @IBAction func tapAddProduto(sender: UIButton) {
        let textoProduto = txtNomeProduto.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if(textoProduto != "") {
            produtos.append(textoProduto)
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellProduto", forIndexPath: indexPath)
        cell.textLabel?.text = produtos[indexPath.row]
        return cell
    }
    
    @IBAction func tapSalvarLista(sender: UIBarButtonItem) {
        
        if(lista == nil) {
            let entityDescription = NSEntityDescription.entityForName("Lista", inManagedObjectContext: self.managedObjectContext!)
            self.lista = Lista(entity: entityDescription!, insertIntoManagedObjectContext: self.managedObjectContext)
        }
        self.lista?.nome = txtNomeLista.text
        var setProdutos = NSMutableSet()
        for produto in produtos {
            setProdutos.addObject(produto!!)
        }
        self.lista?.produtos = NSSet(set: setProdutos)
        do {
            try managedObjectContext?.save()
        } catch {
            print("Erro ao salvar lista")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
