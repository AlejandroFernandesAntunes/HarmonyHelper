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
  let analysis_placeHolder = "Analysis"
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
 
 func analyzeSequence() {
  var harmonized_tones = [String: [String]]()
  
  let tones = ["C", "C#","D","D#","E", "F", "F#", "G", "G#", "A", "A#", "B"]
  
  var coincidences = [String:Int]()
  coincidences["C"] = 0
  coincidences["C#"] = 0
  coincidences["D"] = 0
  coincidences["D#"] = 0
  coincidences["E"] = 0
  coincidences["F"] = 0
  coincidences["F#"] = 0
  coincidences["G"] = 0
  coincidences["A"] = 0
  coincidences["B"] = 0
  
  // harmonizations
  var c = [String]()
  c.append("C")
  c.append("D")
  c.append("E")
  c.append("F")
  c.append("G")
  c.append("A")
  c.append("B")
  harmonized_tones["C"] = c
  
  var d = [String]()
  d.append("C#")
  d.append("D")
  d.append("E")
  d.append("F")
  d.append("G#")
  d.append("A")
  d.append("B")
  harmonized_tones["D"] = d
  
  var e = [String]()
  e.append("C#")
  e.append("D#")
  e.append("E")
  e.append("F")
  e.append("G#")
  e.append("A#")
  e.append("B")
  harmonized_tones["E"] = e
  
  var f = [String]()
  f.append("C")
  f.append("D")
  f.append("E")
  f.append("F")
  f.append("G")
  f.append("A")
  f.append("Bb")
  harmonized_tones["F"] = f
  
  var g = [String]()
  g.append("C#")
  g.append("D")
  g.append("E")
  g.append("F#")
  g.append("G")
  g.append("A")
  g.append("B")
  harmonized_tones["G"] = g
  
  
  
  let sequence = sequenceLbl.text
  let sequenceArr = sequence!.characters.split{$0 == " "}.map(String.init)

  if (sequence != sequence_placeHolder) {
   for tone:String in tones {
     let harmonized:[String]? = harmonized_tones[tone]
       if(harmonized != nil) {
        for grade:String in harmonized!{
         if sequenceArr.contains(grade) {
          coincidences[tone] = coincidences[tone]! + 1
         }
        }
      }
    }
  }
 
 
   // The one that has the more coincidence will be the tone it's on
   let maxim = coincidences.values.maxElement()
   var founded:String = ""
   if(maxim == 0) {
    founded = analysis_placeHolder
   } else {
    for (key, value) in coincidences {
     if (value == maxim)
     {
      founded =  founded + " " + key
     }
    }
   }
  analysisLbl.text = founded
 }

 
  func addChord(newText: String) {
    if(sequenceLbl.text == sequence_placeHolder) {
      sequenceLbl.text = ""
    }
    sequenceLbl.text =  sequenceLbl.text! + " " + newText
    analyzeSequence()
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
   } else {
     analyzeSequence()
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

