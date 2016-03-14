//
//  ViewController.swift
//  HarmonyHelper
//
//  Created by Ale Fernandes Antunes on 3/13/16.
//  Copyright © 2016 Ale Fernandes Antunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  let sequence_placeHolder = "Sequence"
  // MARK: Properties
  @IBOutlet weak var sequenceLbl: UILabel!
  @IBOutlet weak var analysisLbl: UILabel!
  @IBOutlet weak var txtChord: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    txtChord.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func addChord(newText: String) {
    if(sequenceLbl.text == sequence_placeHolder) {
      sequenceLbl.text = ""
    }
    sequenceLbl.text =  sequenceLbl.text! + " " + newText
  }
    
  func removeLastChord() {
   if(sequenceLbl.text != sequence_placeHolder) {
    if(sequenceLbl.text?.characters.count > 2){
     sequenceLbl.text = sequenceLbl.text?.substringToIndex(sequenceLbl.text!.endIndex.advancedBy(-3))
    } else {
     sequenceLbl.text = sequence_placeHolder
    }
   }
   
   if(sequenceLbl.text?.characters.count == 0) {
    sequenceLbl.text=sequence_placeHolder
   }
  }
    
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    //Hide the keyboard
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    addChord(textField.text!)
  }
  // MARK: Actions
  @IBAction func addChordToSequence(sender: UIButton) {
    addChord(txtChord.text!)
  }
    
  @IBAction func removeLastChordFromSequence(sender: UIButton) {
    removeLastChord()
  }
}

