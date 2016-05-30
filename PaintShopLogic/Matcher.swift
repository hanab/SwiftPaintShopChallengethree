//
//  matcher.swift
//  paintsShopTest
//
//  Created by Hana  Demas on 12/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
//class for the matching algoritm which to produce a batch for a given test case
public class Matcher {
    
    //MARK: Properties
    var glossyPref = [Int:[Int]]()/* a property to associate customers glossy color preferences with ID */
    var mattePref = [Int]() // holds the IDs of the matte colors users have chossen
    var matteBatch = [Int]() // holds the batch which should be matte
    var glossyBatch = [Int]() // holds the batchs which should be Glossy
    var solution = [Int]() // The batch which is going to be produced for a given test case
    
    //MARK: Methods
    // a function to check if a customer has at least one glossy
    //preference or the matte preference of the customer is contained
    //in the matted batch
    func customerSatisfied(cust:Customer)->Bool {
        let custGlossyPref = cust.getGlossyPref()
        
        for i in custGlossyPref {
            
            if(glossyBatch.contains(i)) {
                return true
            }
        }
        let mattePref = cust.getMattePref()
        
        if (mattePref > 0 && matteBatch.contains(mattePref)){
            return true
        }
        return false
    }
    
    // function to find the batch which is the final soln
    public func findAllMatches(cust:[Customer], color:Int){
    
        for i in 0...cust.count-1 {
            self.mattePref.append(cust[i].getMattePref())
            //print(mattePref)
            self.glossyPref[i] = cust[i].getGlossyPref()
            //print(glossyPref)
        }
        
        for i in 1...color {
            self.glossyBatch.append(i)
        }
        
        var check:Bool = true
        
        while(check) {
            
            check = false
            
            for i in 0...cust.count-1 {
                if (self.customerSatisfied(cust[i])) {
                    
                    continue
              } else {
                    /* checks if the matte preference is already contained if not add it to the matte batch and remove from the glossy batch*/
                    let mattePref = self.mattePref[i]
                    
                    if(mattePref > 0) {
                        
                        if (!self.matteBatch.contains(mattePref)) {
                            self.matteBatch.append(mattePref)
                            self.glossyBatch = self.glossyBatch.filter({$0 != mattePref})
                            check = true
                        }
                    }
                }
          }
    }
        
        var allSatisfied:Bool = true
        
        for i in 0...cust.count-1 {
            
            if(!self.customerSatisfied(cust[i])) {
                
                allSatisfied = false
                break
            }
        }
        
        if(allSatisfied) {
            
            for i in 1...color{
                
                if(self.matteBatch.contains(i)) {
                    self.solution.append(1)
                }
                else {
                    self.solution.append(0)
                }
            }
            
        } else {
            
            self.solution = []
        }
    }
    
   // print the result batch in the formate specified
    public func resultString() ->String{
        var string = "IMPOSSIBLE"
        
        if self.solution.count > 0 {
            
            let stringArray = self.solution.flatMap { String($0) }
            string = stringArray.joinWithSeparator(" ")
        }
        return string
    }
}