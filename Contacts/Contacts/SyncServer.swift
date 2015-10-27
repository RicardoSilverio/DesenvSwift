//
//  SyncServer.swift
//  Contacts
//
//  Created by Usuário Convidado on 26/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import Foundation

protocol SyncServerDelegate : class {
    func infoSaved()
}

class SyncServer: NSObject {
    
    weak var delegate: SyncServerDelegate?
    
    init(delegate:SyncServerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func saveInfo() {
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "finished", userInfo: nil, repeats: false)
        
        
    }
    
    func finished() {
        self.delegate?.infoSaved()
    }
    
}