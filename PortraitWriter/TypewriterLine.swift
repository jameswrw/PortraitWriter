//
//  TypewriterLine.swift
//  PortraitWriter
//
//  Created by JamesW on 03/03/2018.
//  Copyright © 2018 JamesW. All rights reserved.
//

import Foundation


class TypewriterLine {
    
    let lineNumber: Int?
    let text: String
    var formattedLine: CTLine?
    
    init(lineNumber number:Int?, lineText string:String) {
        lineNumber = number
        text = string
    }
}
