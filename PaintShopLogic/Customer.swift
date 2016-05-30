//
//  customer.swift
//  paintsShopTest
//
//  Created by Hana  Demas on 12/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
// customer class which holds info about customer prefered colors
public class Customer {
    
    //MARK: Properties
    var numberOfPreferedColors:Int! // number of prefered colors 1<T<N
    var listPreferedColors:[ColorString]! // all of the customer preferences
    var customerID:Int! // the ID of the customer
    
    //MARK: Init
    /*initializes the customer object with list of colors and the number
     of prefered colores*/
    public init(id:Int, preferences:[ColorString], numberOfPreferedColors:Int) {
        
        if (preferences.count != numberOfPreferedColors) {
            
            print("Enter all of your Color preferences")
        } else if(self.validateColorPreference(preferences) != true){
            
            print("Can not choose more than one matte color")
        } else {
            
            self.numberOfPreferedColors = numberOfPreferedColors
            self.customerID =  id
            self.listPreferedColors = preferences
        }
    }
    
    //MARK: Methods
    /* function to check if a user has chossen more than one matte color*/
    public func validateColorPreference(preferences:[ColorString])->Bool  {
        var count = 0
        
        for i in 0...preferences.count-1 {
            
            if(preferences[i].type == ColorType.Matte) {
                count = count+1
                
                if(count > 1) {
                    
                    return false
               }
            }
        }
        
        return true
    }
    
    // function to get the color codes of the matte color the user has chossen
   public func getMattePref()->Int {
        var matte = -1
        let mattedPref = self.listPreferedColors.filter({$0.type.rawValue == 1})
    
        if(mattedPref.count != 0) {
            matte = mattedPref[0].colorID
        }
        
        return matte
    }
    
    /* function to get the colorIDs of all the glossy colors the user has chossen
     */
   public func getGlossyPref()->[Int] {
        var glossyColors = [Int]()
        let glossyPref = self.listPreferedColors.filter({$0.type.rawValue == 0})
    
        if(glossyPref.count > 0) {
            for i in 0...glossyPref.count-1 {
                
                glossyColors.append(glossyPref[i].colorID)
          }
        }
        return glossyColors
    }
}