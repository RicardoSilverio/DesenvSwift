//
//  AppDelegate.swift
//  Contacts
//
//  Created by Usuário Convidado on 26/10/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        print("Aplicação vai entrar em segundo plano")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        print("Aplicação entrou em segundo plano")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        print("Aplicação vai ficar ativa")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print("Aplicação ficou ativa")
    }

    func applicationWillTerminate(application: UIApplication) {
        print("Aplicação vai encerrar")
    }


}

