//
//  testCases.swift
//  paintsShopTest
//
//  Created by Hana  Demas on 12/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
//class for reperesenting one test case
public class TestCase {
    
    //MARK: Properties
    var caseNumber:Int
    var numberOfColors:Int
    var customers:[Customer]
    var numberOfCustomers:Int
    
    //MARK: Init
    // initialise one test case
    public init(caseNumber:Int, numberOfColors:Int,customers:[Customer], numberOfCustomers:Int ) {
        self.caseNumber = caseNumber
        self.numberOfColors = numberOfColors
        self.customers = customers
        self.numberOfCustomers = numberOfCustomers
        
    }
}