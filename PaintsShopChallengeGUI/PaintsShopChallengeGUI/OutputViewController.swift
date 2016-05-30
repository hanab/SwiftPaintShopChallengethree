//
//  ViewController.swift
//  PaintsShopChallengeGUI
//
//  Created by Hana  Demas on 13/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit
import PaintShopKitiOS
import QuartzCore
//Viewcontroller class for the view to enter filepath and see the resulting batch
class OutputViewController: UIViewController, InputOutPutDelegate {
  // outlet to show the result color batches
   
        //outlets for output and input file paths
    @IBOutlet var outputTextView: UITextView!
    @IBOutlet var outputField: UITextField!
    @IBOutlet var inputField: UITextField!
    @IBOutlet var inputLabel: UILabel!
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var writeButton: UIButton!
    //instance of the app delegate used to access the Global variable
     var fileNameDelegate=UIApplication.sharedApplication().delegate! as! AppDelegate
   
      // initialize the path to output and input file to the local files in the current project
      var pathToFile:String = NSBundle.mainBundle().pathForResource("input", ofType: "txt")!
      var pathToOutputFile:String = ""
      var path:String = ""

     override func viewDidLoad() {
         super.viewDidLoad()
         // code to style the views
          inputLabel.layer.masksToBounds = true
          inputLabel.layer.cornerRadius = 8
          writeButton.layer.cornerRadius = 8
          outputLabel.layer.masksToBounds = true
          outputLabel.layer.cornerRadius = 8
          outputTextView.layer.borderWidth = 1.0
          outputTextView.layer.cornerRadius = 8
          outputTextView.layer.borderColor = UIColor.grayColor().CGColor

            // by default write to document directory
         let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first!
         self.path = dir.stringByAppendingPathComponent("output.txt")
        
     }
      //set the inputfield to the name of the file created
      override func viewWillAppear(animated: Bool) {
        inputField.text = fileNameDelegate.fileName
        
      }
    
    @IBAction func WriteOutputPressed(sender: AnyObject) {
        // if the user leaves the feilds blank or presses one the file path will be the default , other wise the path is the text written on the correspondin feilds
        if(self.inputField.text == "1" || self.inputField.text == "") {
        
            pathToFile = NSBundle.mainBundle().pathForResource("input", ofType: "txt")!
            print(self.inputField.text!)

       } else {
            /*it is also possible to give the absolut path of the file when running 
             in the simulator by an commneting the second line */
            self.pathToFile = NSTemporaryDirectory() + self.inputField.text!
            //self.pathToFile = self.inputField.text!
        }
        
        if(self.outputField.text == "1" || self.outputField.text == "") {
            
            pathToOutputFile = self.path
        }  else {
            
            self.pathToOutputFile = NSTemporaryDirectory() + self.outputField.text!
        }
        
     // solve for all cases
        let colorSolver = FileParserToObjects(inputFilePath: pathToFile)
        colorSolver.delegate = self
        colorSolver.solveCases()
     }
    
   
    // impements the methods of InputOutputDelegate
    func fileProcessingError(error:String) {
        self.outputTextView.text = error
    }
    
    func outPutText(text:String){
        print(text)
        self.outputTextView.text = text
        
        do {
            try text.writeToFile(pathToOutputFile, atomically: false, encoding: NSUTF8StringEncoding)
        } catch { print("Error Writing to file")}

    }
    
   // end typing by touching any where on the View
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputField.resignFirstResponder()
        outputField.resignFirstResponder()
        
   }
 }

