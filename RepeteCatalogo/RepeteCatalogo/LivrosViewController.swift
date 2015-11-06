//
//  LivrosViewController.swift
//  RepeteCatalogo
//
//  Created by Ricardo Silverio de Souza on 04/11/15.
//  Copyright © 2015 Ricardo Silverio de Souza. All rights reserved.
//

import UIKit

class LivrosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalheViewController:DetalheViewController = segue.destinationViewController as! DetalheViewController
        detalheViewController.isFilme = false
    }
    
    @IBAction func tapLivroButton(sender: UIButton) {
        performSegueWithIdentifier("livrosToDetalheSegue", sender: self)
    }

}
