//
//  ViewController.swift
//  Integracao
//
//  Created by Usuário Convidado on 23/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calc:Calculo = Calculo()
    
    
    @IBOutlet weak var txtValor1: UITextField!
    @IBOutlet weak var txtValor2: UITextField!
    @IBOutlet weak var txtResultado: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapSomar(sender: UIButton) {
        txtResultado.text = "\(calc.somar(Double(txtValor1.text!)!, com: Double(txtValor2.text!)!))"
    }
    
    @IBAction func tapSubtrair(sender: UIButton) {
         txtResultado.text = "\(Calculo.subtrair(Double(txtValor1.text!)!, com: Double(txtValor2.text!)!))"
    }
    


}

