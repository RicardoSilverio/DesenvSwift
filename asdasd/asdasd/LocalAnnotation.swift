//
//  LocalAnnotation.swift
//  asdasd
//
//  Created by Usuário Convidado on 09/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit
import MapKit

class LocalAnnotation: NSObject, MKAnnotation {
    
    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var item:MKMapItem
    
    init(coordinate:CLLocationCoordinate2D, title:String, subtitle:String, item:MKMapItem) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.item = item
    }


}
