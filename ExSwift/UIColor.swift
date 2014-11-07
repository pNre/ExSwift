//
//  PKColor.swift
//  PKLibrary
//
//  Created by Piergiuseppe Longo on 09/10/14.
//  Copyright (c) 2014 Piergiuseppe Longo. All rights reserved.
//

import Foundation
import UIKit

// MARK: Flat Colors

let FlatTurquoise       = "#1abc9c"
let FlatEmerald         = "#2ecc71"
let FlatPeterRiver      = "#3498db"
let FlatAmethyst        = "#9b59b6"
let FlatWetAsphalt      = "#34495e"
let FlatGreenSea        = "#16a085"
let FlatNephitis        = "#27ae60"
let FlatBelizeHole      = "#2980b9"
let FlatWisteria        = "#8e44ad"
let FlatMidnightBlue    = "#2c3e50"
let FlatSunFlower       = "#f1c40f"
let FlatCarrot          = "#e67e22"
let FlatAlizarin        = "#e74c3c"
let FlatClouds          = "#ecf0f1"
let FlatConcrete        = "#95a5a6"
let FlatOrange          = "#f39c12"
let FlatPumpkin         = "#d35400"
let FlatPomeGranade     = "#c0392b"
let FlatSilver          = "#bdc3c7"
let FlatAsbestos        = "#7f8c8d"


let flatColors = [
    FlatTurquoise,
    FlatEmerald,
    FlatPeterRiver,
    FlatAmethyst,
    FlatWetAsphalt,
    FlatGreenSea,
    FlatNephitis,
    FlatBelizeHole,
    FlatWisteria,
    FlatMidnightBlue,
    FlatSunFlower,
    FlatCarrot,
    FlatAlizarin,
    FlatClouds,
    FlatConcrete,
    FlatOrange,
    FlatPumpkin,
    FlatPomeGranade,
    FlatSilver,
    FlatAsbestos,
    
];

public extension UIColor {
    
    // MARK: Init
    
    /**
    Initializes a UIColor with the provided hexString.
    
    :param: hexString The hex color string
    
    :returns: The color
    */
    convenience init(hexString: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if hexString.hasPrefix("#") {
            let index   = advance(hexString.startIndex, 1)
            let hex     = hexString.substringFromIndex(index)
            
            let scanner = NSScanner(string: hex);
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                
                if hex.length == 6 {
                    red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if hex.length == 8 {
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                } else {
                    println("invalid rgb string, length should be 7 or 9")
                }
            } else {
                println("scan hex error")
            }
        } else {
            println("invalid rgb string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    // MARK:  Class Functions
    
    /**
    Generate a random UIColor.
    
    :returns: A random UIColor
    */
    class func randomColor () -> UIColor {
        let red = CGFloat((random() % 255))/255 ;
        let green = CGFloat((random() % 255))/255 ;
        let blue = CGFloat((random() % 255))/255 ;
        let alpha = CGFloat((random() % 255))/255 ;
        return UIColor(red: red, green: green, blue: blue, alpha: alpha);
        
    }
    
    /**
    Generate a random flat UIColor
    
    :returns: A random flat UIColor
    */
    class func randomFlatcolor () -> UIColor {
        let randomColor = random() % flatColors.count;
        return UIColor(hexString: flatColors[randomColor] );
    }
    
    
    // MARK:  Flat UIColor getter
    
    class func flatTurquoiseColor() -> UIColor{
        return UIColor(hexString: FlatTurquoise);
    }
    
    class func flatEmeraldColor() -> UIColor{
        return UIColor(hexString: FlatEmerald);
    }
    
    class func flatAmethystColor() -> UIColor{
        return UIColor(hexString: FlatAmethyst);
    }
    
    class func flatWetAsphaltColor() -> UIColor{
        return UIColor(hexString: FlatWetAsphalt);
    }
    
    class func flatGreenSeaColor() -> UIColor{
        return UIColor(hexString: FlatGreenSea);
    }
    
    class func flatNephitisColor() -> UIColor{
        return UIColor(hexString: FlatNephitis);
    }
    
    class func flatBelizeHoleColor() -> UIColor{
        return UIColor(hexString: FlatBelizeHole);
    }
    
    class func flatWisteriaColor() -> UIColor{
        return UIColor(hexString: FlatWisteria);
    }
    
    class func flatMidnightBlueColor() -> UIColor{
        return UIColor(hexString: FlatMidnightBlue);
    }
    
    class func flatSunFlowerColor() -> UIColor{
        return UIColor(hexString: FlatSunFlower);
    }
    
    class func flatCarrotColor() -> UIColor{
        return UIColor(hexString: FlatCarrot);
    }
    
    class func flatAlizarinColor() -> UIColor{
        return UIColor(hexString: FlatAlizarin);
    }
    
    class func flatCloudsColor() -> UIColor{
        return UIColor(hexString: FlatClouds);
    }
    
    class func flatConcreteColor() -> UIColor{
        return UIColor(hexString: FlatConcrete);
    }
    
    class func flatOrangeColor() -> UIColor{
        return UIColor(hexString: FlatOrange);
    }
    
    class func flatPomeGranadeColor() -> UIColor{
        return UIColor(hexString: FlatPomeGranade);
    }
    
    class func flatSilverColor() -> UIColor{
        return UIColor(hexString: FlatSilver);
    }
    
    class func flatAsbestosColor() -> UIColor{
        return UIColor(hexString: FlatAsbestos);
    }
    
    
}

