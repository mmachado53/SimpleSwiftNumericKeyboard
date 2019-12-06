//  NumericKeyBoard.swift
//  SimpleSwiftNumericKeyboard
//
//  Created by Miguel Machado on 12/5/19.
//  Copyright © 2019 Miguel Machado. All rights reserved.
//

import UIKit

// MARK: Enum, Type of keyboard
public enum KeyBoardType {
    case decimalPad             /// enable "." key disable "-" key
    case decimalNegativePad     /// enable "." and "-" keys
    case numberPad              /// disable "." and "-" keys
    case numberNegativePad      /// disbale "." key enable "-" key
}

public class NumericKeyBoard : UIView, UIInputViewAudioFeedback {
    
    
    
    
    // MARK: Private Static vars
    private static let numbers:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    // MATK: Public vars
    public var type:KeyBoardType = .decimalPad
    
    // MARK: fileprivate vars
    fileprivate weak var textView: UITextInput?
    
    // MARK: Outlets
    @IBOutlet var decimalPointBtn:UIButton?
    @IBOutlet var btns:[UIButton]?
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: Static methods
    
    /**
     Create and configure a new intance of NumericKeyBoard.
     
     - Parameters:
     - textView: the UITextInput to configure
     - type: type of configuration for NumericKeyBoard
     - Returns: A NumericKeyBoard instanse.
     */
    @discardableResult public static func set(_ textView: UITextInput, type: KeyBoardType) -> NumericKeyBoard?{
        let podBundle = Bundle(for: NumericKeyBoard.self)
        let nib:UINib = UINib(nibName: "NumericKeyBoard", bundle: podBundle)
        let instance = nib.instantiate(withOwner: self, options: nil).first as! NumericKeyBoard
        instance.type = type
        instance.setup(textView, type: type)
        return instance
        
    }
    
    
    
    // MARK: Private methods
    
    /**
     setup NumericKeyBoard.
     - Parameters:
     - textView: the UITextInput to configure
     - type: type of configuration for NumericKeyBoard
     */
    private func setup(_ textView: UITextInput, type: KeyBoardType){
        self.textView = textView
        minusButton.isEnabled = type == .decimalNegativePad || type == .numberNegativePad
        if let textView = self.textView as? UITextField {
            textView.inputView = self
        }
        if let textView = self.textView as? UITextView {
            textView.inputView = self
        }
        
        if #available(iOS 9.0, *) {
            removeToolbar()
        }
        if let btns:[UIButton] = self.btns {
            btns.forEach { (button) in
            }
        }
        self.decimalPointBtn?.isEnabled = type == .decimalNegativePad || type == .decimalPad
        self.decimalPointBtn?.setTitle((Locale.current as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as? String, for: UIControl.State.normal)
    }
    
    /// Notifications for textview
    private func notificateTextDidChange(){
        if let textField:UITextField = self.textView as? UITextField {
            NotificationCenter.default.post(name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
        }else if let textView:UITextView = self.textView as? UITextView {
            NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: textView)
        }
    }
    
    /// Remove Undo/Redo toolbar
    @available(iOS 9.0, *)
    fileprivate func removeToolbar()
    {
        var item : UITextInputAssistantItem?
        if let txtView = self.textView as? UITextField {
            item = txtView.inputAssistantItem
        }
        if let txtView = self.textView as? UITextView {
            item = txtView.inputAssistantItem
        }
        item?.leadingBarButtonGroups = []
        item?.trailingBarButtonGroups = []
    }
    
    // MARK: Default Size
    
    override open var intrinsicContentSize : CGSize
    {
        return CGSize(width: 100, height: 313)
    }
    
    
    // MARK: UIInputViewAudioFeedback
    
    open var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    // MARK: Events
    
    @IBAction fileprivate func numbersButtonPressed(_ sender: UIButton)
    {
        UIDevice.current.playInputClick()
        if sender.tag >= 0 && sender.tag  < 10{
            let char = NumericKeyBoard.numbers[sender.tag]
            textView?.insertText(char)
            self.notificateTextDidChange()
        }
    }
    
    @IBAction fileprivate func decimalPointButtonPressed(_ sender: UIButton){
        UIDevice.current.playInputClick()
        let decimalChar = (Locale.current as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as? String ?? "."
        textView?.insertText(decimalChar)
        self.notificateTextDidChange()
    }
    
    @IBAction fileprivate func negativeButtonPressed(_ sender: UIButton){
        UIDevice.current.playInputClick()
        textView?.insertText("-")
        self.notificateTextDidChange()
    }
    
    @IBAction fileprivate func deleteButtonPressed(_ sender: UIButton){
        UIDevice.current.playInputClick()
        textView?.deleteBackward()
        self.notificateTextDidChange()
    }
    
    @IBAction fileprivate func hideKeyBoardButtonPressed(_ sender:UIButton){
        if let textField:UITextField = self.textView as? UITextField {
            textField.resignFirstResponder()
        }else if let textView:UITextView = self.textView as? UITextView {
            textView.resignFirstResponder()
        }
    }
}

class KeyBoardButtonStyleA : UIButton{
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                self.backgroundColor = UIColor.lightGray
            }else{
                self.backgroundColor = UIColor.white
            }
        }
    }
}

class KeyBoardButtonStyleB : UIButton{
    override var isEnabled: Bool{
        didSet{
            self.alpha = isEnabled ? 1.0 : 0.2
        }
    }
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                self.backgroundColor = UIColor.gray
            }else{
                self.backgroundColor = UIColor.lightGray
            }
        }
    }
}

/// extencion for storyboard implementation
extension UITextField{
    @IBInspectable public var keyboardNumericType:String {
        get{
            if let numericKeyboard:NumericKeyBoard = self.inputView as? NumericKeyBoard{
                return numericKeyboard.type == .numberPad ? "numeric" : "decimal"
            }
            return ""
        }
        set{
            if newValue.lowercased() == "numeric"{
                NumericKeyBoard.set(self, type: .numberPad)
            }else if newValue.lowercased() == "decimal"{
                NumericKeyBoard.set(self, type: .decimalPad)
            }else if newValue.lowercased() == "decimalnegative"{
                NumericKeyBoard.set(self, type: .decimalNegativePad)
            }else if newValue.lowercased() == "numericnegative"{
                NumericKeyBoard.set(self, type: .numberNegativePad)
            }
            
        }
    }
}
