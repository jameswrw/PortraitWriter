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
    
    let typewriter = Typewriter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do view setup here.
        var ctLines = [[CTLine]]()
        let output = typewriter.parser.parse()
        let font = NSFont.init(name: "Courier New", size: 8.0)
        
        for line in output.lines {
            var ctLine = [CTLine]()
            for run in line {
                let string = NSAttributedString.init(string: run + "\n", attributes:[.font : font!])
                ctLine.append(CTLineCreateWithAttributedString(string))
            }
            ctLines.append(ctLine)
        }
        
        typeView.text = ctLines
        typeView.setNeedsDisplay(typeView.bounds)
    }
    
}
