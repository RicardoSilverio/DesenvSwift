//
//  ViewController.swift
//  FrutasAlinhadas
//
//  Created by Usuário Convidado on 11/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackFrutas: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapSwitchHorizontal(sender: UISwitch) {
        UIView.animateWithDuration(1) { () -> Void in
            if(sender.on) {
                self.stackFrutas.axis = UILayoutConstraintAxis.Horizontal
            } else {
                self.stackFrutas.axis = UILayoutConstraintAxis.Vertical
            }
        }
        
    }

}

