//
//  MetroAnnotation.swift
//  asdasd
//
//  Created by Usuário Convidado on 09/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MapKit

class MetroAnnotation: NSObject, MKAnnotation {
    
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

}
