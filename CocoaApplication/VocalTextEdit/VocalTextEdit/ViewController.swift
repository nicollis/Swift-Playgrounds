//
//  ViewController.swift
//  VocalTextEdit
//
//  Created by Nic Ollis on 12/12/17.
//  Copyright © 2017 Nic Ollis. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    let speechSynthesizer = NSSpeechSynthesizer()

    @IBOutlet var textView: NSTextView!
    
    var contents : String {
        get {
            return textView.string
        }
        set {
            textView.string = newValue
        }
    }
    
    @IBAction func speakButtonClicked(_ sender: NSButton){
        if !textView.string.isEmpty {
            speechSynthesizer.startSpeaking(textView.string)
        } else {
            speechSynthesizer.startSpeaking("The document is empty")
        }
    }
    
    @IBAction func stopButtonClicked(_ sender: NSButton){
        speechSynthesizer.stopSpeaking()
    }

}

