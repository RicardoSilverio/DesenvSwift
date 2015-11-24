//
//  RSSDetalheViewController.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class RSSDetalheViewController: UIViewController {
    
    @IBOutlet weak var txtNome: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var txtEndereco: UILabel!
    @IBOutlet weak var loadingFoto: UIActivityIndicatorView!
    
    var nome:String?
    var stringURLImagem:String?
    var endereco:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = NSURLSession.sharedSession()
        let task = session.downloadTaskWithURL(NSURL(string: stringURLImagem!)!) { (url, urlResponse, error) -> Void in
            
            if(error != nil) {
                print("Erro ao carregar imagem")
            }
            
            let imageData = NSData(contentsOfURL: url!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imgFoto.image = UIImage(data: imageData!)
                self.loadingFoto.stopAnimating()
            })
            
        }
        task.resume()
        loadingFoto.startAnimating()
        txtNome.text = nome
        txtEndereco.text = endereco
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
