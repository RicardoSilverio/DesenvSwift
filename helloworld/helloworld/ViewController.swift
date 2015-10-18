//
//  ViewController.swift
//  helloworld
//
//  Created by Usuário Convidado on 02/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var botaoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sayHello(sender: UIButton) {
        botaoLabel.text = "Hello World!"
        sender.setTitle("Clicado", forState: UIControlState.Normal)
        sender.setTitle("Clicando!!!", forState: UIControlState.Highlighted)
    }

}

