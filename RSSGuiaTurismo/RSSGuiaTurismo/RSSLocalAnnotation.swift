//
//  RSSLocalAnnotation.swift
//  RSSGuiaTurismo
//
//  Created by Usuário Convidado on 18/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MapKit

class RSSLocalAnnotation: NSObject, MKAnnotation {
    
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var stringURLImagem:String?
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, stringURLImagem:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.stringURLImagem = stringURLImagem
    }
    
    
}
