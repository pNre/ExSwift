//
//  NSNumberFormatter.swift
//  ExSwift
//
//  Created by Piergiuseppe Longo on 07/03/15.
//  Copyright (c) 2015 pNre. All rights reserved.
//

import UIKit

public extension NSNumberFormatter{
    func setPrecision(precision: Int){
        self.minimumFractionDigits = precision
        self.maximumFractionDigits = precision
    }
}
