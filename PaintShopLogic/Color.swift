//
//  color.swift
//  paintsShopTest
//
//  Created by Hana  Demas on 12/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
//enumrate all the possible paint types
public enum ColorType: Int {
    case Glossy = 0
    case Matte = 1
    
}
// a structcure to represent a paint as an ID and a type
public struct ColorString {
    var colorID = 0
    var type:ColorType
}

