//
//  ViewController.swift
//  Calculadora
//
//  Created by Usuário Convidado on 17/10/15.
//  Copyright © 2015 Silvr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblResultado: UILabel!
    
    var arrayItens:[String] = [String]()
    var temResultado:Bool = false
    var calcOp:CalcOperation = CalcOperation()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchTap(sender: UIButton) {
        if(sender.titleLabel!.text! == "CA") {
            lblResultado.text = ""
            temResultado = false
            arrayItens.removeAll()
        } else {
            let entrada:String = sender.titleLabel!.text!
            if(entrada == "+" || entrada == "-" || entrada == "x" || entrada == "/") {
                if(arrayItens.count == 0) {
                    return
                } else {
                    let ultimo:String = arrayItens[arrayItens.count - 1]
                    if(ultimo != "+" && ultimo != "-" && ultimo != "x" && ultimo != "/") {
                        if(temResultado) {
                            let result:Double = calcOp.calculateWithArray(arrayItens)
                            lblResultado.text = "\(result)"
                            temResultado = false
                        }
                        arrayItens.append(sender.titleLabel!.text!)
                    }
                }
            } else {
                if(arrayItens.count == 0) {
                    arrayItens.append(sender.titleLabel!.text!)
                    lblResultado.text = lblResultado.text! + sender.titleLabel!.text!
                } else {
                    let ultimo:String = arrayItens[arrayItens.count - 1]
                    if(ultimo == "+" || ultimo == "-" || ultimo == "x" || ultimo == "/") {
                        if(ultimo == "/" && entrada == "0") {
                            return
                        } else {
                            temResultado = true
                            arrayItens.append(sender.titleLabel!.text!)
                            lblResultado.text = sender.titleLabel!.text!
                        }
                    
                    } else{
                        arrayItens[arrayItens.count - 1] = arrayItens[arrayItens.count - 1] + entrada
                        lblResultado.text = lblResultado.text! + sender.titleLabel!.text!
                    }
                }
            }
            
        }
    }

    @IBAction func calculate(sender: UIButton) {
        if(temResultado) {
            let result:Double = calcOp.calculateWithArray(arrayItens)
            lblResultado.text = "\(result)"
        }
    }
}

