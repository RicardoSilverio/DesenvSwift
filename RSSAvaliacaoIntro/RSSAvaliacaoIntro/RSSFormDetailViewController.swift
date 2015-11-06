//
//  RSSFormDetailViewController.swift
//  RSSAvaliacaoIntro
//
//  Created by Usuário Convidado on 04/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class RSSFormDetailViewController: UIViewController {
    
    var theName:String?
    var theEmail:String?
    var thePhone:String?
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.text = theName
        txtEmail.text = theEmail
        txtPhone.text = thePhone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
