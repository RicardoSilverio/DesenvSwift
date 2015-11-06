//
//  FilmesTableViewController.swift
//  RepeteCatalogo
//
//  Created by Ricardo Silverio de Souza on 04/11/15.
//  Copyright © 2015 Ricardo Silverio de Souza. All rights reserved.
//

import UIKit

class FilmesTableViewController: UITableViewController, DetalheViewControllerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalheViewController:DetalheViewController = segue.destinationViewController as! DetalheViewController
        detalheViewController.isFilme = true
        detalheViewController.delegate = self
    }

    @IBAction func tapFilmeButton(sender: UIButton) {
        performSegueWithIdentifier("filmesToDetalheSegue", sender: self)
    }
    
    func alugarFilmeComTitulo(titulo: String) {
        let actionSheet:UIAlertController = UIAlertController(title: "Filme", message: "Filme " + titulo + " alugado com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
        actionSheet.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }

}
