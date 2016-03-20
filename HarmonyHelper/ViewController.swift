//
//  ViewController.swift
//  HarmonyHelper
//
//  Created by Ale Fernandes Antunes on 3/13/16.
//  Copyright © 2016 Ale Fernandes Antunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 let sequence_placeHolder = "Sequence"
 let analysis_placeHolder = "please add more chords to the sequence to start the analysis"
 var chordtoAdd = ""
 var addedChords:[String] = []
 var available_chords = [["C", "C#","D","D#","E","F","F#","G","G#","A","A#","B"],["Maj","min","dim"],["7", "7Maj"]]
 var avaiable_chords = [
  "CMaj7",
  "C7",
  "Cmin",
  "Cdim",
  "C#Maj7",
  "C#7",
  "C#min",
  "C#dim",
  "DMaj7",
  "D7",
  "Dmin",
  "Ddim",
  "D#Maj7",
  "D#7",
  "D#min",
  "D#dim",
  "EMaj7",
  "E7",
  "Emin",
  "Edim",
  "FMaj7",
  "F7",
  "Fmin",
  "Fdim",
  "F#Maj7",
  "F#7",
  "F#min",
  "F#dim",
  "GMaj7",
  "G7",
  "Gmin",
  "Gdim",
  "G#Maj7",
  "G#7",
  "G#min",
  "G#dim",
  "AMaj7",
  "A7",
  "Amin",
  "Adim",
  "A#Maj7",
  "A#7",
  "A#min",
  "A#dim",
  "BMaj7",
  "B7",
  "Bmin",
  "Bdim"
 ]
 
 // MARK: Properties
 @IBOutlet weak var sequenceLbl: UILabel!
 @IBOutlet weak var analysisLbl: UILabel!
 @IBOutlet weak var chordsPicker: UIPickerView!

 @IBOutlet weak var btnAddChord: UIButton!
    @IBOutlet weak var btnRemoveChord: UIButton!
    @IBOutlet weak var lblMusicNote: UILabel!
 
 override func viewDidLoad() {
  super.viewDidLoad()
  chordsPicker.dataSource = self;
  chordsPicker.delegate = self;
  
  //background color
  //self.view.backgroundColor = UIColor.grayColor()
  
  // FontAwesome icon in add/reomve buttons
  btnAddChord.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
  btnAddChord.setTitle(String.fontAwesomeIconWithName(.PlusSquareO), forState: .Normal)
  
  btnRemoveChord.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
  btnRemoveChord.setTitle(String.fontAwesomeIconWithName(.MinusSquareO), forState: .Normal)
  
  
  lblMusicNote.font = UIFont.fontAwesomeOfSize(15)
  lblMusicNote.text = String.fontAwesomeIconWithName(.Music)
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
  c.append("CMaj7")
  c.append("Dmin7")
  c.append("Emin7")
  c.append("FMaj7")
  c.append("G7")
  c.append("Amin")
  c.append("Bdim")
  harmonized_tones["C"] = c
  
  var d = [String]()
  d.append("C#dim")
  d.append("DMaj7")
  d.append("Emin7")
  d.append("Fmin7")
  d.append("G#Maj7")
  d.append("A7")
  d.append("Bmin")
  harmonized_tones["D"] = d
  
  
  var e = [String]()
  e.append("C#min")
  e.append("D#dim")
  e.append("EMaj7")
  e.append("Fmin7")
  e.append("G#min7")
  e.append("A#Maj7")
  e.append("B7")
  harmonized_tones["E"] = e
  
  var f = [String]()
  f.append("C7")
  f.append("Dmin")
  f.append("Edim")
  f.append("FMaj7")
  f.append("Gmin")
  f.append("Amin")
  f.append("BbMaj7")
  harmonized_tones["F"] = f
  
  var g = [String]()
  g.append("C#Maj7")
  g.append("D7")
  g.append("Emin")
  g.append("F#dim")
  g.append("GMaj7")
  g.append("Amin")
  g.append("Bmin")
  harmonized_tones["G"] = g
  
  var a = [String]()
  a.append("C#min")
  a.append("D#Maj7")
  a.append("E7")
  a.append("F#min")
  a.append("G#dim")
  a.append("AMaj7")
  a.append("Bmin")
  harmonized_tones["A"] = a
  
  var b = [String]()
  b.append("C#min")
  b.append("D#min")
  b.append("E#Maj7")
  b.append("F#7")
  b.append("G#min")
  b.append("A#dim")
  b.append("BMaj7")
  harmonized_tones["B"] = b
  
  
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
   //array and set for uniques
   founded = "The sequence can be interpreted as a vamp, try using Major/minor pentatonic of: \(Array(Set(addedChords)).joinWithSeparator("-"))"
  } else {
   for (key, value) in coincidences {
    if (value == maxim)
    {
     founded =  founded + " " + key
    }
   }
   founded = "That sequence of chords is contained in the Ionian mode of: \(founded)."
  }
  analysisLbl.text = founded
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
 
 // pragma MARK: UIPickerViewDelegate
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

