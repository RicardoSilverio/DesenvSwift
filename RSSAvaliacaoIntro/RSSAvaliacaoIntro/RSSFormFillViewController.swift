//
//  RSSFormFillViewController.swift
//  RSSAvaliacaoIntro
//
//  Created by Usuário Convidado on 04/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class RSSFormFillViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.delegate = self
        txtEmail.delegate = self
        txtPhone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailViewController:RSSFormDetailViewController = segue.destinationViewController as! RSSFormDetailViewController
        detailViewController.theName = txtName.text
        detailViewController.theEmail = txtEmail.text
        detailViewController.thePhone = txtPhone.text
    }

    @IBAction func tapNextButton(sender: UIButton) {
        performSegueWithIdentifier("formToDetailSegue", sender: self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField.tag {
            case 1:
                txtName.resignFirstResponder()
                txtEmail.becomeFirstResponder()
            case 2:
                txtEmail.resignFirstResponder()
                txtPhone.becomeFirstResponder()
            default:
                txtPhone.resignFirstResponder()
        }
        return true
    }

}
