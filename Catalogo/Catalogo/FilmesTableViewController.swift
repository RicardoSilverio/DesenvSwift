//
//  FilmesTableViewController.swift
//  Catalogo
//
//  Created by Usuário Convidado on 28/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class FilmesTableViewController: UITableViewController, DetalheViewControllerDelegate {
    
    func buttonTapWithPart(part: Int) {
        let actionSheet = UIAlertController(title: "Filme", message: "Parte " + String(part), preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalheViewController:DetalheViewController = segue.destinationViewController as! DetalheViewController
        detalheViewController.itemIdx = sender!.tag
        detalheViewController.isFromLivro = false
        detalheViewController.delegate = self
    }
    
    @IBAction func buttonFilmeTap(sender: UIButton) {
        self.performSegueWithIdentifier("filmesToDetalheSegue", sender: sender)
    }

}
