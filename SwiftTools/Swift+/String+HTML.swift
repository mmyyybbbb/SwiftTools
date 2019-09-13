//
//  String+HTML.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 28/03/2019.
//  Copyright © 2019 BCS. All rights reserved.
//
public extension String {

    /**
     Создает строку из переданного html кода.

     - parameter htmlEncodedString: html код в виде строки.
     */
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }

    /**
     Получает атрибутную строку из текущей строки, которая является html кодом.

     - returns: Атрибутная строка.
     */
    var htmlToAttributed: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }

    /**
     Очищает текущую строку от html тегов и заменяет их читабельными символами.

     - returns: Преобразованная строка.
     */
    var clearedFromHTMLTags: String {
        var escapedString = self
        escapedString = escapedString.remove(["<p>"])
        escapedString = escapedString.replace(["</p>"], with: "\n")
        escapedString = escapedString.replace(["<br/>", "<br />"], with: "\n\n")
        escapedString = escapedString.remove(["<strong>", "</strong>"])
        escapedString = escapedString.remove(["<ul>", "</ul>", "</li>"])
        escapedString = escapedString.replace(["<li>"], with: "● ")

        escapedString = escapedString.unescaped

        return escapedString
    }

    /**
     Преобразует в текущей строке специальные символы в символы html.

     - returns: Преобразовання строка.
     */
    var escaped: String {
        var escapedString = self

        for item in HtmlSymbols.allValues {
            escapedString = escapedString.replacingOccurrences(of: item.rawValue, with: item.escapeadSymbol())
        }

        return escapedString
    }

    /**
     Преобразует в текущей строке символы html в специальные символы.

     - returns: Преобразовання строка.
     */
    var unescaped: String {
        var unescapedString = self

        for item in HtmlSymbols.allValues {
            unescapedString = unescapedString.replacingOccurrences(of: item.escapeadSymbol(), with: item.rawValue)
        }

        return unescapedString
    }

    fileprivate enum HtmlSymbols: String {
        case and    = "&"
        case left   = "«"
        case right  = "»"
        case quot   = "\""
        case gt     = ">"
        case lt     = "<"
        case mdash  = "—"
        case ndash  = "–"
        case space  = " "

        static let allValues = [and, left, right, quot, gt, lt, mdash, ndash, space]

        func escapeadSymbol() -> String {
            switch self {
            case .and    : return "&amp;"
            case .left   : return "&laquo;"
            case .right  : return "&raquo;"
            case .quot   : return "&quot;"
            case .gt     : return "&gt;"
            case .lt     : return "&lt;"
            case .mdash  : return "&mdash;"
            case .ndash  : return "&ndash;"
            case .space  : return "&nbsp;"
            }
        }
    }
}
