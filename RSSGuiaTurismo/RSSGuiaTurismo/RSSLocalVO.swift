//
//  RSSLocalVO.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class RSSLocalVO: NSObject {
    
    var nome:String?
    var endereco:String?
    var imagem:String?
    var lat:Double?
    var long:Double?
    
    init(nome:String, endereco:String, imagem:String, lat:Double, long:Double) {
        self.nome = nome
        self.endereco = endereco
        self.imagem = imagem
        self.lat = lat
        self.long = long
    }

}
