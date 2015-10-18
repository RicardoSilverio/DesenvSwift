//
//  CalcOperation.swift
//  Calculadora
//
//  Created by Usuário Convidado on 17/10/15.
//  Copyright © 2015 Silvr. All rights reserved.
//

import UIKit

class CalcOperation: NSObject {
    
    func calculateWithArray(arrayItens:[String]) -> Double {
        var result:Double = 0.0
        var operacao:String = ""
        for item:String in arrayItens {
            if(operacao == "") {
                switch item {
                    case "+":
                        operacao = "+"
                    case "-":
                        operacao = "-"
                    case "x":
                        operacao = "x"
                    case "/":
                        operacao = "/"
                default:
                        result = result + Double(item)!
                }
            } else {
                switch operacao {
                    case "+":
                        result = result + Double(item)!
                    case "-":
                        result = result - Double(item)!
                    case "x":
                        result = result * Double(item)!
                    case "/":
                        result = result / Double(item)!
                    default:
                        operacao = ""
                }
                operacao = ""
            }
        }
        return result
    }

}
