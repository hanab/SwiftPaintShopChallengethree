//
//  OutputViewController.swift
//  PaintsShopChallengeGUI
//
//  Created by Hana  Demas on 17/04/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit
//a viewcontroller class for the view to create input file
class FileViewController: UIViewController {

    @IBOutlet var writeToFileButton: UIButton!
    //outlets for input file name and content
    @IBOutlet var fileContentTextView: UITextView!
    @IBOutlet var fileNameField: UITextField!
    
    @IBOutlet var fileContentLable: UILabel!
    //instance of the app delegate used to access the Global variable
    var fileNameDelegate=UIApplication.sharedApplication().delegate! as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // styling diffrent views
        fileContentTextView.layer.borderWidth = 1.0
        fileContentTextView.layer.cornerRadius = 8
        fileContentTextView.layer.borderColor = UIColor.grayColor().CGColor
        fileContentLable.layer.masksToBounds = true
        fileContentLable.layer.cornerRadius = 8
        writeToFileButton.layer.masksToBounds = true
        writeToFileButton.layer.cornerRadius = 8

    }
    
    //write input to file
    @IBAction func writeToFilePressed(sender: AnyObject) {
        
        let inputFileContent = fileContentTextView.text!
        //write to the temporary directory of the app, this works also in the real device
        let destinationPath = NSTemporaryDirectory() + fileNameField.text!
        
        do {
            try inputFileContent.writeToFile(destinationPath, atomically: false, encoding: NSUTF8StringEncoding)
            print("file Written to destinaltion:  \(destinationPath)")
            
       } catch { print("Error Writing to file")}
        //Set the Global variable
        fileNameDelegate.fileName = fileNameField.text
        
    }
    
    //resign from input feild by tapping anywhere in the screen
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        fileContentTextView.resignFirstResponder()
        fileNameField.resignFirstResponder()
        
    }

}
