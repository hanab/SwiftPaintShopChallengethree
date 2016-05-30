//
//  dataParserFromFile.swift
//  paintsShopTest
//
//  Created by Hana  Demas on 12/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//
// a protocol which can be implemented with classes which use the MyFileParser class
public protocol InputOutPutDelegate {
    func fileProcessingError(error:String)
    func outPutText(text:String)
}

import Foundation
// a class to read all the data from a file , parse them into approprate objects and find the result color batch for all test cases
public class FileParserToObjects {
    
    //MARK: Properties
    var testCases:[TestCase] = []//Grab all test cases
    public var delegate:InputOutPutDelegate? // an instance of the delegate
    var solver:Matcher = Matcher()
    
    //MARK: Init
    /* The object is initialize using input file */
    public init(inputFilePath:String) {
        var lines:[String] = []
        let data: String?
        
        do {
            data = try String(contentsOfFile: inputFilePath)
        } catch _ {
            data = nil
            print("Error in Reading file")
        }
        
        if let content = data {
            lines = content.componentsSeparatedByString("\n")
        }
        
        var lineCount = 0
        let numberOfTestCases = Int(lines[lineCount])!
        
        outerLoop: for i in 1...numberOfTestCases {
            
            let testCase = i
            let numberOfPaints = (lines[lineCount+1]).toInt()
            let numberOfCustomers = (lines[lineCount+2]).toInt()
            lineCount = lineCount+2
            var customers = [Customer]()
            
            for j in 1...numberOfCustomers {
                
                let customerPrefLine = lines[j + lineCount]
                let prefArray = customerPrefLine.componentsSeparatedByString(" ")
                let numberOfPref = (prefArray[0]).toInt()
                
                if(numberOfPref<1) {
                    
                    delegate?.fileProcessingError("Customer must have at least one color choice")
                    break outerLoop
                    
                } else if(numberOfPref != (prefArray.count - 1)/2) {
                    delegate?.fileProcessingError("Specified prefered color doesnt much with the number of colors entered")
                    break outerLoop
                }
                
                let cus = Customer(id:j, preferences:(self.getCustomerFromLine(prefArray)), numberOfPreferedColors:numberOfPref)
                    customers.append(cus)
            }
            
            lineCount = lineCount+numberOfCustomers
            self.testCases.append(TestCase(caseNumber:testCase, numberOfColors:numberOfPaints, customers:customers, numberOfCustomers:numberOfCustomers))
            
            if(self.testCases.count != numberOfTestCases) {
                
                delegate?.fileProcessingError("Test case number doesnt much with the case numbers extracted from file")
                
            }
        }
    }
    
    //MARK: Methods
    // parse the line for a customer preferences 
    public func getCustomerFromLine(line:[String])->[ColorString] {
        var prefcolors = [ColorString]()
        
        for var i = 1; i < line.count; i += 1 {
            let color = ColorString(colorID:Int(line[i])!, type:ColorType(rawValue:Int(line[i+1])!)!)
            i = i+1
            prefcolors.append(color)
        }
        
        return prefcolors
   }
    
    //a function to get the batchs for all test cases
    public func solveCases()->String {
        var solutionToAllCases:String = ""
        
        for i in 0...self.testCases.count-1 {
            
            solver = Matcher()
            solver.findAllMatches(testCases[i].customers, color: testCases[i].numberOfColors)
            
            let str =  "Case #\(self.testCases[i].caseNumber): " + solver.resultString() + "\n "
            solutionToAllCases += str
            
        }
        delegate?.outPutText(solutionToAllCases)
        return solutionToAllCases
    }
}