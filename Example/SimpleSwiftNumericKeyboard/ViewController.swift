//
//  ViewController.swift
//  SimpleSwiftNumericKeyboard
//
//  Created by mmachado53 on 12/05/2019.
//  Copyright (c) 2019 mmachado53. All rights reserved.
//

import UIKit
import SimpleSwiftNumericKeyboard

class ViewController: UIViewController {
    
    @IBOutlet var tf:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var redStyle:[NumericKeyBoardColorPaletteProp:UIColor] = [:]
        redStyle[.backgroundColor] = UIColor(red: 0.85, green: 0, blue: 0.21, alpha: 1.0)
        redStyle[.stateNormalNumberButton] = UIColor(red: 1.0, green: 0, blue: 0.21, alpha: 1.0)
        redStyle[.statePressNumerButton] = UIColor.white.withAlphaComponent(0.3)
        redStyle[.textColorNumberButton] = UIColor.white
        redStyle[.stateNormalSecondaryButton] = UIColor(red: 0.75, green: 28 / 255, blue: 70 / 255, alpha: 1.0)
        redStyle[.statePressSecondaryButton] = UIColor.white.withAlphaComponent(0.3)
        redStyle[.textColorSecondaryButton] = UIColor.white
        NumericKeyBoard.set(tf, type: .numberNegativePad,customPalette: redStyle)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

