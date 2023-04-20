//
//  Extensions.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import SwiftUI
import UIKit

// MARK: - Collection
public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
// MARK: - MutableCollection
public extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
// MARK: - NSObject
public extension NSObject {
    static var className: String {
        return NSStringFromClass(self)
            .components(separatedBy: ".")
            .last ?? NSStringFromClass(self)
    }
}
// MARK: - String
public extension String {
    func localized(tableName: String? = nil,
                          bundle: Bundle = .main,
                          comment: String = "") -> String {
        return NSLocalizedString(
            self,
            tableName: tableName,
            bundle: bundle,
            value: "",
            comment: comment)
    }
    
    func localizedWith(params: [CVarArg], withBundle bundle: Bundle) -> String {
        return String(format: localized(bundle: bundle), arguments: params)
    }
    
    func getBoldAttributedString(boldString: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let boldAttributedString: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        
        let range = (self as NSString).range(of: boldString)
        
        attributedString.addAttributes(boldAttributedString, range: range)
        
        return attributedString
    }
}
// MARK: - UITableView
public extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .tertiary
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
// MARK: - UIColor
public extension UIColor {
    static var primary: UIColor { UIColor(named: CustomColors.primary.rawValue) ?? .red }
    static var secondary: UIColor { UIColor(named: CustomColors.secondary.rawValue) ?? .red }
    static var tertiary: UIColor { UIColor(named: CustomColors.tertiary.rawValue) ?? .red }
    static var quaternary: UIColor { UIColor(named: CustomColors.quaternary.rawValue) ?? .red }
}
