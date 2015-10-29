//
//  DetalheViewController.swift
//  Catalogo
//
//  Created by Usuário Convidado on 28/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

protocol DetalheViewControllerDelegate {
    func buttonTapWithPart(part:Int)
}

class DetalheViewController: UIViewController {
    
    var itemIdx:Int? = 0
    var isFromLivro:Bool = false
    
    var delegate:DetalheViewControllerDelegate?

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblItemTitulo: UILabel!
    @IBOutlet weak var btnParte1: UIButton!
    @IBOutlet weak var btnParte2: UIButton!
    
    let arrayLivros:[String] = ["Futebol - Uma janela para o Brasil", "A terra dos sonhos", "Manga", "Como se faz"]
    let arrayFilmes:[String] = ["2012", "Avatar", "Thor", "Anjos da Noite"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isFromLivro) {
            btnClose.hidden = false
            lblTitulo.text = "Livro"
            lblItemTitulo.text = arrayLivros[itemIdx!]
            btnParte1.hidden = true
            btnParte2.hidden = true
        } else {
            btnClose.hidden = true
            lblTitulo.text = "Filme"
            lblItemTitulo.text = arrayFilmes[itemIdx!]
            btnParte1.hidden = false
            btnParte2.hidden = false
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonPartTap(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        delegate?.buttonTapWithPart(sender.tag)
    }
    
    @IBAction func closeTap(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
