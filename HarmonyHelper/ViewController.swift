//
//  ViewController.swift
//  HarmonyHelper
//
//  Created by Ale Fernandes Antunes on 3/13/16.
//  Copyright © 2016 Ale Fernandes Antunes. All rights reserved.
//

import UIKit
import FlatUIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 let sequence_placeHolder = "Sequence"
 let analysis_placeHolder = "please add more chords to the sequence to start the analysis"
 var chordtoAdd = ""
 var addedChords:[String] = []
 var available_chords = [["C", "C#","D","D#","E","F","F#","G","G#","A","A#","B"],["Maj","min","dim"],["7", "7Maj"]]
 var harmonized_tones = [String: [String]]()
 
 // MARK: Properties
 @IBOutlet weak var chordsPicker: UIPickerView!
 // labels
 @IBOutlet weak var sequenceLbl: UILabel!
 @IBOutlet weak var lblSubtitle: UILabel!
 @IBOutlet weak var titleLabel: UILabel!
 // buttons
 @IBOutlet weak var btnAddChord: FUIButton!
 @IBOutlet weak var btnRemoveChord: FUIButton!
 // textViews
 @IBOutlet weak var txtAnalysis: UITextView!
 
 override func viewDidLoad() {
  super.viewDidLoad()
  chordsPicker.dataSource = self;
  chordsPicker.delegate = self;
  
  txtAnalysis.text = analysis_placeHolder
  sequenceLbl.text = sequence_placeHolder

  
  btnAddChord.buttonColor = UIColor(red: 67.0/255.0, green: 72.0/255.0, blue: 77.0/255.0, alpha: 1.0)
  btnAddChord.shadowColor = UIColor(red: 65.0/255.0, green: 75.0/255.0, blue: 80.0/255.0, alpha: 1.0)
  btnAddChord.shadowHeight = 3;
  btnAddChord.cornerRadius = 0;
  btnAddChord.titleLabel!.font = UIFont.boldFlatFontOfSize(16);
  
  
  btnRemoveChord.buttonColor = UIColor(red: 67.0/255.0, green: 72.0/255.0, blue: 77.0/255.0, alpha: 1.0)
  btnRemoveChord.shadowColor = UIColor(red: 65.0/255.0, green: 75.0/255.0, blue: 80.0/255.0, alpha: 1.0)
  btnRemoveChord.shadowHeight = 3
  btnRemoveChord.cornerRadius = 0
  
  readPlist()
  
 }
 
 func readPlist() {
  var harmonies: NSDictionary?
  if let path = NSBundle.mainBundle().pathForResource("harmonies", ofType: "plist") {
   harmonies = NSDictionary(contentsOfFile: path)
  }
  if let dict = harmonies {
   harmonized_tones["C"] = dict["C"] as? [String]
   harmonized_tones["D"] = dict["D"] as? [String]
   harmonized_tones["E"] = dict["E"] as? [String]
   harmonized_tones["F"] = dict["F"] as? [String]
   harmonized_tones["G"] = dict["G"] as? [String]
   harmonized_tones["A"] = dict["A"] as? [String]
   harmonized_tones["B"] = dict["B"] as? [String]
  }
 }
 
 override func viewDidLayoutSubviews() {
  let air:CGFloat = 30
  let currentDevice: UIDevice = UIDevice.currentDevice()
  let orientation : UIDeviceOrientation = currentDevice.orientation
  
  var nextStackedYPos:CGFloat = 0
  
  super.viewDidLayoutSubviews()
  titleLabel.sizeToFit()
  
  //TODO function to size receiving an element as parameter
  
  // In order of appearence
  if (orientation.isPortrait) {
   
   //portrait
   titleLabel.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.titleLabel.bounds.width / 2),
    air,
    self.titleLabel.bounds.width,
    self.titleLabel.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.titleLabel.bounds.height + air
   
   lblSubtitle.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.lblSubtitle.bounds.width / 2),
    nextStackedYPos,
    self.lblSubtitle.bounds.width,
    self.lblSubtitle.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.lblSubtitle.bounds.height + air
   
   chordsPicker.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.chordsPicker.bounds.width / 2),
    nextStackedYPos,
    self.chordsPicker.bounds.width,
    self.chordsPicker.bounds.height)
   chordsPicker.backgroundColor = UIColor(red: 200.0/255.0, green: 205.0/255.0, blue: 206.0/255.0, alpha: 1.0)
   
   nextStackedYPos = nextStackedYPos + self.chordsPicker.bounds.height + air
   
   
   btnRemoveChord.frame = CGRectMake(
    15,
    nextStackedYPos,
    130,
    30)
   
   btnAddChord.frame = CGRectMake(
    self.view.bounds.width - (self.btnRemoveChord.bounds.width + 15),
    nextStackedYPos,
    130,
    30)
   
   nextStackedYPos = nextStackedYPos + self.btnAddChord.bounds.height + air
   
   sequenceLbl.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.sequenceLbl.bounds.width / 2),
    nextStackedYPos ,
    self.sequenceLbl.bounds.width,
    self.sequenceLbl.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.sequenceLbl.bounds.height + air
   
   txtAnalysis.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.txtAnalysis.bounds.width / 2),
    nextStackedYPos,
    self.txtAnalysis.bounds.width,
    self.txtAnalysis.bounds.height)
  } else {
   let leftBound:CGFloat = 10
   
   
   //landscape
   titleLabel.frame = CGRectMake(
    leftBound,
    air,
    self.titleLabel.bounds.width,
    self.titleLabel.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.titleLabel.bounds.height + air
   
   lblSubtitle.frame = CGRectMake(
    leftBound,
    nextStackedYPos,
    self.lblSubtitle.bounds.width,
    self.lblSubtitle.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.lblSubtitle.bounds.height + air
   
   chordsPicker.frame = CGRectMake(
    leftBound,
    nextStackedYPos,
    self.chordsPicker.bounds.width,
    self.chordsPicker.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.chordsPicker.bounds.height + air
   
   
   btnRemoveChord.frame = CGRectMake(
    leftBound,
    nextStackedYPos,
    130,
    30)
   
   btnAddChord.frame = CGRectMake(
    leftBound,
    nextStackedYPos,
    130,
    30)
   
   nextStackedYPos = nextStackedYPos + self.btnAddChord.bounds.height + air
   
   sequenceLbl.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.sequenceLbl.bounds.width / 2),
    nextStackedYPos ,
    180,
    self.sequenceLbl.bounds.height)
   
   nextStackedYPos = nextStackedYPos + self.sequenceLbl.bounds.height + air
   
   txtAnalysis.frame = CGRectMake(
    (self.view.bounds.width / 2) - (self.txtAnalysis.bounds.width / 2),
    nextStackedYPos,
    self.txtAnalysis.bounds.width,
    self.txtAnalysis.bounds.height)

  }
 }
 
 func analyzeSequence() {
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
  
  if (addedChords.count > 0) {
   for tone:String in tones {
    let harmonized:[String]? = harmonized_tones[tone]
    if(harmonized != nil) {
     for grade:String in harmonized!{
      let upperAddedChords = addedChords.map { $0.uppercaseString}
      if upperAddedChords.contains(grade.uppercaseString) {
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
   if(addedChords.count == 0) {
    founded = analysis_placeHolder
   }else{
    //array and set for uniques
    founded = "The sequence can be interpreted as a vamp, try using Major/minor pentatonic of: \(Array(Set(addedChords)).joinWithSeparator("-"))"
   }
  } else {
   for (key, value) in coincidences {
    if (value == maxim)
    {
     founded =  founded + " " + key
    }
   }
   founded = "That sequence of chords is contained in the Ionian mode of: \(founded)."
  }
  txtAnalysis.text = founded
 }
 
 func addChord(newText: String) {
  addedChords.append(newText)
  if(sequenceLbl.text == sequence_placeHolder) {
   sequenceLbl.text = ""
  }
  sequenceLbl.text =  addedChords.joinWithSeparator("-")
  analyzeSequence()
 }
 
 func removeLastChord() {
  if(addedChords.count > 0) {
   addedChords.removeLast()
   sequenceLbl.text =  addedChords.joinWithSeparator("-")
   analyzeSequence()
  } else{
   sequenceLbl.text = sequence_placeHolder
  }
 }
 
 // MARK: UIPickerViewDataSource Delegate
 //how many componentns the picker has
 func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
  return 3
 }
 // this says each compoonent how many items have
 func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
  if component == 0 {
   return 12
  }
  if component == 1 {
   return 3
  }
  if component == 2{
   return 2
  }
  return 0
 }
 
 // MARK: UIPickerViewDelegate
 //this is call when picker view is created
 func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  return available_chords[component][row]
 }
 //this is call when picker view option is selected
 func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  let root = available_chords[0][pickerView.selectedRowInComponent(0)]
  let nature = available_chords[1][pickerView.selectedRowInComponent(1)]
  let seventh = available_chords[2][pickerView.selectedRowInComponent(2)]
  
  if nature.lowercaseString == "min" || nature.lowercaseString == "dim" {
   chordtoAdd = root + nature
  }
  
  if nature.lowercaseString == "maj" && seventh == "7" {
   chordtoAdd = root + seventh
  }
  
  if nature.lowercaseString == "maj" && seventh == "7Maj" {
   chordtoAdd = root + nature + "7"
  }
 }
 
 // MARK: Actions
 @IBAction func addChordToSequence(sender: UIButton) {
  if(chordtoAdd.characters.count > 0) {
   addChord(chordtoAdd)
  }
 }
 
 @IBAction func removeLastChordFromSequence(sender: UIButton) {
  removeLastChord()
 }
}

