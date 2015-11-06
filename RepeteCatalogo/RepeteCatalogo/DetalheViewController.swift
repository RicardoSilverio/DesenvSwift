//
//  DetalheViewController.swift
//  RepeteCatalogo
//
//  Created by Ricardo Silverio de Souza on 04/11/15.
//  Copyright © 2015 Ricardo Silverio de Souza. All rights reserved.
//

import UIKit

protocol DetalheViewControllerDelegate {
    
    func alugarFilmeComTitulo(titulo:String)
}

class DetalheViewController: UIViewController {
    
    @IBOutlet weak var btnFechar: UIButton!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var btnAlugar: UIButton!
    
    var delegate:DetalheViewControllerDelegate?
    
    var isFilme:Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if(isFilme) {
            btnFechar.hidden = true
            btnAlugar.hidden = false
            lblTitulo.text = "2012"
        } else {
            btnFechar.hidden = false
            btnAlugar.hidden = true
            lblTitulo.text = "Futebol"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapFecharButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapAlugarButton(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.alugarFilmeComTitulo(lblTitulo.text!)
    }
    
}
