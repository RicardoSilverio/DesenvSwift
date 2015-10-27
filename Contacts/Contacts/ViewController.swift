//
//  ViewController.swift
//  Contacts
//
//  Created by Usuário Convidado on 26/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, SyncServerDelegate {
    
    let label:UILabel = UILabel(frame: CGRectMake(120, 30, 200, 30))

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var segSexo: UISegmentedControl!
    @IBOutlet weak var lblIdade: UILabel!
    @IBOutlet weak var swtFavorito: UISwitch!
    @IBOutlet weak var lblFormaContato: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Nome"
        self.view.addSubview(label)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("View ficará visível")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("View está visível")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func idadeMudou(sender: UIStepper) {
        let idade:Int = Int(sender.value)
        lblIdade.text = String(idade)
    }

    @IBAction func mudarFormaContato(sender: UIButton) {
        let actionSheet:UIAlertController = UIAlertController(title: "Contato", message: "Escolha a forma de contato", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "E-mail", style: UIAlertActionStyle.Default,
            handler: { _ in
                self.lblFormaContato.text! = "E-mail"
            }
        ))
        
        actionSheet.addAction(UIAlertAction(title: "Telefone", style: UIAlertActionStyle.Default,
            handler: { _ in
                self.lblFormaContato.text! = "Telefone"
            }
        ))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel,
            handler: nil
        ))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func salvarContato(sender: UIButton) {
        let sync:SyncServer = SyncServer(delegate: self)
        sync.saveInfo()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func infoSaved() {
        let actionSheet:UIAlertController = UIAlertController(title: "Contato", message: "Contato salvo com sucesso", preferredStyle: UIAlertControllerStyle.Alert)
        
        actionSheet.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
}

