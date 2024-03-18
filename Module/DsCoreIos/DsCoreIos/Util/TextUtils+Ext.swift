//
//  TextUtils.swift
//  DS_ExpertIOS
//
//  Created by Admin on 21/02/24.
//

import UIKit

extension String {
  public func convertHtml() -> NSMutableAttributedString {
    guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
    do {
      return try NSMutableAttributedString(
        data: data,
        options: [.documentType: NSMutableAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
        documentAttributes: nil
      )
    } catch {
      return NSMutableAttributedString()
    }
  }
}

extension NSMutableAttributedString {
  public func replaceFont(with font: UIFont) {
    beginEditing()
    self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { value, range, _ in
      if let f = value as? UIFont {
        let ufd = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits)!
        let newFont = UIFont(descriptor: ufd, size: f.pointSize)
        removeAttribute(.font, range: range)
        addAttribute(.font, value: newFont, range: range)
      }
    }
    endEditing()
  }
}
