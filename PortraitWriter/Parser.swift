//
//  TypewriterParser.swift
//  PortraitWriter
//
//  Created by JamesW on 27/02/2018.
//  Copyright © 2018 JamesW. All rights reserved.
//

import Foundation


class Parser {
    
    var path: URL!
    var previousLineNumber = 1
    
    init() {
//        path = Bundle.main.url(forResource: "Charles", withExtension: "txt")!
//        path = Bundle.main.url(forResource: "Mystery", withExtension: "txt")!
        path = Bundle.main.url(forResource: "Rose", withExtension: "txt")!
    }
    
    func parse() -> [TypewriterLine] {
        
        previousLineNumber = 1
        
        let input = try! String(contentsOf: path, encoding: .utf8)
        let lines = input.split(separator: "\n")
        
        let output = lines.map { (line) -> TypewriterLine in
            
            let parsedLine = parse(line: line)
            
            if parsedLine.lineNumber != nil {
                if parsedLine.lineNumber! > previousLineNumber {
                    previousLineNumber = parsedLine.lineNumber!
                }
            }
            return parsedLine
        }
        
        return output
    }
    
    func parse(line: Substring) -> TypewriterLine {
        
        
        let regexPattern = "(-?\\d*)(.*)"

        var components = line.split(separator: " ")
        let lineNumberComponent = components.removeFirst()
        
        switch lineNumberComponent {
        case "RED", "BLACK":
            return TypewriterLine(lineNumber: nil, lineText: String(lineNumberComponent))
            
        case "LINE":
            let lineString = components.removeFirst()
            let lineNumber = Int(lineString)!
            previousLineNumber = lineNumber
            return TypewriterLine(lineNumber: nil, lineText: String(lineNumberComponent))
            
        default:
            assert(lineNumberComponent.first == "(")
            assert(lineNumberComponent.last == ")")
            
            var lineNumberString = lineNumberComponent.replacingOccurrences(of: "(", with: "")
            lineNumberString = lineNumberString.replacingOccurrences(of: ")", with: "")
            
            let results = matches(for: regexPattern, in: String(lineNumberString))
            let lineNumber = Int(results[0])!
            assert(lineNumber == previousLineNumber || lineNumber == previousLineNumber + 1)
            
            var parsedLine = ""

            for component in components {
                let results = matches(for: regexPattern, in: String(component))
                let repeatCount = Int(results[0])!
                
                for _ in 0..<repeatCount {
                    if results[1] == "sp" {
                        parsedLine += " "
                    } else {
                        assert(results[1].count == 1)
                        parsedLine += results[1]
                    }
                }
            }
            
            return TypewriterLine(lineNumber: lineNumber, lineText: parsedLine)
        }
    }
    
    
    // Cocoa regexes are cancer.
    func matches(for regexPattern: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            
            var matches = [String]()
            if let result = results.first {
                for i in 1..<result.numberOfRanges {
                    let range = result.range(at: i)
                    if let range = Range(range, in: text) {
                        let matchText = text[range]
                        matches.append(String(matchText))
                    }
                }
            }
            return matches
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
