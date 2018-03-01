//
//  TypeView.swift
//  PortraitWriter
//
//  Created by JamesW on 01/03/2018.
//  Copyright © 2018 JamesW. All rights reserved.
//

import Cocoa

class TypeView: NSView {

    var text: [[CTLine]]? = nil
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        if let context = NSGraphicsContext.current?.cgContext {
            
            let xMargin: CGFloat = 72.0
            let yMargin: CGFloat = bounds.size.height - 72.0
            
            if let text = text {
                
                for i in 0..<text.count {
                    for line in text[i] {
                        
                        // Calculate line separation such that rows/cm == columns/cm.
                        let glyphCount = CTLineGetGlyphCount(line)
                        let lineRect = CTLineGetBoundsWithOptions(line, .excludeTypographicLeading)
                        let lineHeight = lineRect.size.width / CGFloat(glyphCount)
                        
                        context.textPosition = CGPoint(x: xMargin, y: yMargin - CGFloat(i) * lineHeight)
                        CTLineDraw(line, context)
                    }
                }
            }
        }
    }
}
