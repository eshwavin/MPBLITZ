//
//  Contants.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 07/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

// MARK: - General

func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    
}

let themeColor = color(red: 225, green: 76, blue: 74, alpha: 1.0)
//let themeColor2 = color(red: 255, green: 45, blue: 85, alpha: 1.0)

let onlineColor = UIColor.white
let offlineColor = color(red: 5, green: 48, blue: 25, alpha: 1.0)

func showAlert(_ title: String!, message: String!) -> UIAlertController {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    return alertController
}


// MARK: - Reachability

let WIFI = "WIFI Available"

let NOACCESS = "No Internet Access"

let WWAN = "Cellular Access Available"

func noInternetAccessAlert() -> UIAlertController {
    return showAlert("No internet access!", message: "Please connect to the internet and try again")
}

func getGradeintLayer(with frame: CGRect) -> CAGradientLayer {
    
    let layer = CAGradientLayer()
    layer.frame = frame
    
    layer.colors = [color(red: 0, green: 122, blue: 255, alpha: 1.0).cgColor, color(red: 1, green: 45, blue: 26, alpha: 1.0).cgColor]
    
    layer.startPoint = CGPoint(x: 0.0, y: 0.0)
    layer.endPoint = CGPoint(x: 0.0, y: 1.0)
    layer.locations = [0.0, 1.0]
    
    return layer
}
