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

public enum NumericKeyBoardColorPaletteProp {
    case stateNormalNumberButton        /// background color for number buttons in normal state
    case statePressNumerButton          /// background color for number buttons in pressed state
    case textColorNumberButton          /// Text color for Number buttons
    case stateNormalSecondaryButton     /// background color for buttons ".","-", "delete Backward" and "hide" in normal state
    case statePressSecondaryButton      /// background color for buttons ".","-", "delete Backward" and "hide" in pressed state
    case textColorSecondaryButton       /// Text Color for buttons ".","-", "delete Backward" and "hide"
    case backgroundColor                /// Background color for keyboard
}

public class NumericKeyBoard : UIView, UIInputViewAudioFeedback {
    
    
    // MARK: Private Static vars
    private static let numbers:[String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    // MARK: Global Color Palette
    public static var GLOBAL_COLOR_PALETTE:[NumericKeyBoardColorPaletteProp:UIColor] = [
        .stateNormalNumberButton: UIColor.white,
        .statePressNumerButton : UIColor.lightGray,
        .textColorNumberButton : UIColor.darkText,
        .stateNormalSecondaryButton : UIColor.lightGray,
        .statePressSecondaryButton :  UIColor.gray,
        .textColorSecondaryButton : UIColor.darkText,
        .backgroundColor : UIColor(red: 0.81, green: 0.83, blue: 0.85, alpha: 1.0)
    ]
    
    // MATK: Public vars
    public var type:KeyBoardType = .decimalPad
    
    // MARK: fileprivate vars
    fileprivate weak var textView: UITextInput?
    
    // MARK: Outlets
    @IBOutlet var decimalPointBtn:SimpleCustomBtn?
    @IBOutlet var btns:[SimpleCustomBtn]?
    @IBOutlet weak var minusButton: SimpleCustomBtn!
    @IBOutlet weak var ereaseButton: SimpleCustomBtn!
    @IBOutlet weak var dismissButton: SimpleCustomBtn!
    
    
    // MARK: Static methods
    
    /**
     Create and configure a new intance of NumericKeyBoard.
     
     - Parameters:
     - textView: the UITextInput to configure
     - type: type of configuration for NumericKeyBoard
     - customPalette: OPTIONAL its a custom Colors palette for the new NumericKeyBoard instance (override the global palette)
     - Returns: A NumericKeyBoard instanse.
     */
    @discardableResult public static func set(_ textView: UITextInput, type: KeyBoardType, customPalette:[NumericKeyBoardColorPaletteProp:UIColor]?=nil) -> NumericKeyBoard?{
        let podBundle = Bundle(for: NumericKeyBoard.self)
        let nib:UINib = UINib(nibName: "NumericKeyBoard", bundle: podBundle)
        let instance = nib.instantiate(withOwner: self, options: nil).first as! NumericKeyBoard
        instance.setup(textView, type: type)
        instance.setupColorPalette(customPalette: customPalette)
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
        self.type = type
        
        if let textView = self.textView as? UITextField {
            textView.inputView = self
        }
        if let textView = self.textView as? UITextView {
            textView.inputView = self
        }
        if #available(iOS 9.0, *) {
            removeToolbar()
        }
        
        self.decimalPointBtn?.isEnabled = type == .decimalNegativePad || type == .decimalPad

        self.decimalPointBtn?.setTitle((Locale.current as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as? String, for: UIControl.State.normal)
        
        minusButton.isEnabled = type == .decimalNegativePad || type == .numberNegativePad
        
        
    }
    
    /// Notifications for textview
    private func notificateTextDidChange(){
        if let textField:UITextField = self.textView as? UITextField {
            NotificationCenter.default.post(name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
        }else if let textView:UITextView = self.textView as? UITextView {
            NotificationCenter.default.post(name: NSNotification.Name.UITextViewTextDidChange, object: textView)
        }
    }
    
    private func setupColorPalette(customPalette:[NumericKeyBoardColorPaletteProp:UIColor]?){
        // Merge color palettes
        var currentPalette:[NumericKeyBoardColorPaletteProp:UIColor]
        if customPalette != nil {
            currentPalette = [:]
            for (key,value) in NumericKeyBoard.GLOBAL_COLOR_PALETTE{
                currentPalette[key] = customPalette!.index(forKey: key) == nil ? value : customPalette![key]
            }
        }else{
            currentPalette = NumericKeyBoard.GLOBAL_COLOR_PALETTE
        }
        
        if let btns:[SimpleCustomBtn] = self.btns {
            btns.forEach { (button) in
                button.configureColors(normalBg: currentPalette[.stateNormalNumberButton]!, pressedBg: currentPalette[.statePressNumerButton]!, textColor: currentPalette[.textColorNumberButton]!)
            }
        }
        
        // APPLY COLORS
        self.decimalPointBtn?.configureColors(normalBg: currentPalette[.stateNormalSecondaryButton]!, pressedBg: currentPalette[.statePressSecondaryButton]!, textColor: currentPalette[.textColorSecondaryButton]!)
        
        self.minusButton.configureColors(normalBg: currentPalette[.stateNormalSecondaryButton]!, pressedBg: currentPalette[.statePressSecondaryButton]!, textColor: currentPalette[.textColorSecondaryButton]!)
        
        self.ereaseButton.configureColors(normalBg: currentPalette[.stateNormalSecondaryButton]!, pressedBg: currentPalette[.statePressSecondaryButton]!, textColor: currentPalette[.textColorSecondaryButton]!)
        self.dismissButton.configureColors(normalBg: currentPalette[.stateNormalSecondaryButton]!, pressedBg: currentPalette[.statePressSecondaryButton]!, textColor: currentPalette[.textColorSecondaryButton]!)
        self.backgroundColor = currentPalette[.backgroundColor]
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

class SimpleCustomBtn:UIButton{
    public var normalBg:UIColor = UIColor.white
    public var pressedBg:UIColor = UIColor.lightGray
    override var isEnabled: Bool{
        didSet{
            self.alpha = isEnabled ? 1.0 : 0.2
        }
    }
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                self.backgroundColor = self.pressedBg
            }else{
                self.backgroundColor = self.normalBg
            }
        }
    }
    public func configureColors(normalBg:UIColor,pressedBg:UIColor,textColor:UIColor){
        self.pressedBg = pressedBg
        self.normalBg = normalBg
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(textColor, for: .disabled)
        self.setTitleColor(textColor, for: .highlighted)
        self.backgroundColor = self.isHighlighted ? self.pressedBg : self.normalBg
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
