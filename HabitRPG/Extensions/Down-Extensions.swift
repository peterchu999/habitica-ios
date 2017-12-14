//
//  Down-Extensions.swift
//  Habitica
//
//  Created by Phillip Thelen on 09/03/2017.
//  Copyright © 2017 HabitRPG Inc. All rights reserved.
//

import Foundation
import Down

extension Down {

    func toHabiticaAttributedString() throws -> NSMutableAttributedString {
        return try self.toHabiticaAttributedString(baseFont: UIFont.preferredFont(forTextStyle: .body))
    }

    func toHabiticaAttributedString(baseFont: UIFont) throws -> NSMutableAttributedString {
        guard let string = try self.toAttributedString().mutableCopy() as? NSMutableAttributedString else {
            return NSMutableAttributedString()
        }
        let fontSizeOffset = baseFont.pointSize - 12.0
        string.enumerateAttribute(NSAttributedStringKey.font,
                                  in: NSRange(location: 0, length: string.length),
                                  options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired,
                                  using: { (value, range, _) in
            if let oldFont = value as? UIFont {
                let font: UIFont
                if oldFont.fontName.lowercased().contains("bold") {
                    font = UIFont.boldSystemFont(ofSize: oldFont.pointSize+fontSizeOffset)
                } else if oldFont.fontName.lowercased().contains("italic") {
                    font = UIFont.italicSystemFont(ofSize: oldFont.pointSize+fontSizeOffset)
                } else {
                    font = UIFont.systemFont(ofSize: oldFont.pointSize+fontSizeOffset)
                }
                string.addAttribute(NSAttributedStringKey.font, value: font, range: range)
            }
        })
        return string
    }
}

class HabiticaMarkdownHelper: NSObject {
    
    @objc
    static func toHabiticaAttributedString(_ text: String) throws -> NSMutableAttributedString {
        if let attributedString =  try? Down(markdownString: text).toHabiticaAttributedString() {
            return attributedString
        }
        return NSMutableAttributedString(string: text)
    }
}
