//
//  AttributedTextViewSubclassDemo.swift
//  AttributedTextView
//
//  Created by Edwin Vermeer on 03/03/2017.
//  Copyright © 2017 evermeer. All rights reserved.
//

import AttributedTextView
import UIKit

@IBDesignable class AttributedTextViewSubclassDemo: AttributedTextView {
    
    // Add this field in interfacebuilder and make sure the interface is updated after changes
    @IBInspectable var linkText: String? {
        didSet { configureAttributedTextView() }
    }

    // Add this field in interfacebuilder and make sure the interface is updated after changes
    @IBInspectable var linkUrl: String? {
        didSet { configureAttributedTextView() }
    }
    
    // Configure our custom styling.
    override func configureAttributedTextView() {
        if let text = self.text, let linkText = self.linkText, let linkUrl = self.linkUrl {
            self.attributer = text.green.match(linkText).makeInteract { _,_  in
                if #available(iOS 10, *) {
                    UIApplication.shared.open(URL(string: linkUrl)!, options: [:], completionHandler: { completed in })
                } else {
                    _ = UIApplication.shared.openURL(URL(string: linkUrl)!)
                }
            }
        } else {
            self.attributer = (self.text ?? "").green
        }
        layoutIfNeeded()
    }
}
