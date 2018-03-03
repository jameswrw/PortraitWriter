//
//  TypewriterViewController.swift
//  PortraitWriter
//
//  Created by JamesW on 27/02/2018.
//  Copyright © 2018 JamesW. All rights reserved.
//

import Cocoa
import AppKit


class TypewriterViewController: NSViewController {

    @IBOutlet var typeView: TypeView!
    
    let parser = Parser()
    var colour = NSColor.black
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do view setup here.
        let lines = parser.parse()
        let font = NSFont.init(name: "Courier New", size: 18.0)
        
        for line in lines {
            
            if line.text == "RED" {
                colour = .red
            } else if line.text == "BLACK" {
                colour = .black
            } else {
                let string = NSAttributedString.init(string: line.text + "\n", attributes:[.font : font!, .foregroundColor: colour])
                line.formattedLine = CTLineCreateWithAttributedString(string)
            }
            
        }
        
        typeView.lines = lines
        typeView.setNeedsDisplay(typeView.bounds)
    }
    
}
