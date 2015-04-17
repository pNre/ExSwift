//
//  CharacterExtensions.swift
//  ExSwift
//
//  Created by Cenny Davidsson on 2014-12-09.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class CharacterExtensionsSpec: QuickSpec {
    
    override func spec() {
        
        it("toInt") {
    
            expect(Character("7").toInt()) == 7
    
            expect(Character("a").toInt()).to(beNil())

        }
        
    }

}
