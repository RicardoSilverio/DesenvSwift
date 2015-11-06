//
//  RSSMyImageViewController.swift
//  RSSAvaliacaoIntro
//
//  Created by Usuário Convidado on 04/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class RSSMyImageViewController: UIViewController, RSSImageSelectViewControllerDelegate {

    @IBOutlet weak var imgFruit: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let imageSelectViewController:RSSImageSelectViewController = segue.destinationViewController as! RSSImageSelectViewController
        imageSelectViewController.delegate = self
    }
    
    @IBAction func tapButtonSelect(sender: UIButton) {
        performSegueWithIdentifier("myImageToImageSelectSegue", sender: self)
    }
    
    func fruitIsSelected(fruitName:String) {
        imgFruit.image = UIImage(named: fruitName)
    }

}
