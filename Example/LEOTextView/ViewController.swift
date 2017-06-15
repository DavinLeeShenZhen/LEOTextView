//
//  ViewController.swift
//  LEOTextView
//
//  Created by leonardo-hammer on 04/21/2017.
//  Copyright (c) 2017 leonardo-hammer. All rights reserved.
//

import UIKit
import LEOTextView

class ViewController: UIViewController, UITextViewDelegate {
    let textAttributesJSONKey = "textAttributesJSON"

    var textView: LEOTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "LEOTextView"

        // Init and config TextView
        textView = LEOTextView(frame: self.view.bounds, textContainer: NSTextContainer())
		textView.enableToolbar(view)
        textView.nck_delegate = self
		
		textView.tintColor = UIColor(red: 0x9B/255.0, green: 0x9B/255.0, blue: 0x9B/255.0, alpha: 1)
		textView.textColor = textView.tintColor
		textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        // add to View
        self.view.addSubview(textView)

        textView.becomeFirstResponder()
    }

    @IBAction func saveButtonAction(_ sender: AnyObject) {
        textView.resignFirstResponder()

        let textAttributesJSON = textView.textAttributesJSON()

        UserDefaults.standard.setValue(textAttributesJSON, forKey: textAttributesJSONKey)

        print("textAttributesJSON: \(textAttributesJSON)")

        alert("Current attributed text export to JSON string successed and saved.")
    }

    @IBAction func loadButtonAction(_ sender: AnyObject) {
        textView.resignFirstResponder()

        let textAttributesJSON = UserDefaults.standard.value(forKey: textAttributesJSONKey)
        if textAttributesJSON != nil {
            textView.setAttributeTextWithJSONString(textAttributesJSON as! String)
        }
    }

    func alert(_ message: String) {
        let alertController = UIAlertController(title: "Saved", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - UITextViewDelegate

    func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
}

