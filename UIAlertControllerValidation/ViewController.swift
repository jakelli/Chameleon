//
//  ViewController.swift
//  UIAlertControllerValidation
//
//  Created by Jacob Ellious on 5/22/17.
//  Copyright © 2017 Jacob Ellious. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController {
  
  @IBOutlet weak var outPut: UITextView!
  
  weak var actionToEnable : UIAlertAction?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let windowRect = UIScreen.main.bounds
    self.view.backgroundColor = UIColor.init(gradientStyle: UIGradientStyle.topToBottom, withFrame: windowRect, andColors: [UIColor.orange, UIColor.red])
    
    self.outPut.backgroundColor = UIColor.white.withAlphaComponent(0.0)
  }

  @IBAction func testButton(_ sender: AnyObject) {
    
      let titleStr = "Self Validating UITextField"
      let messageStr = "Enter a number 1-60"
      let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert)
      let placeholderStr =  "1-60"
      
      alert.addTextField(configurationHandler: {(textField: UITextField) in
        textField.placeholder = placeholderStr
        textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
      })
      
      let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (_) -> Void in
        // perform cancel action (optional) else change to nil
      })
      
      let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (_) -> Void in
        let textfield = alert.textFields!.first!
        // perform your action - textfield is valid
        self.outPut.text = textfield.text
      })
      
      alert.addAction(cancel)
      alert.addAction(action)
    
      alert.view.tintColor = UIColor.orange
      
      self.actionToEnable = action
      action.isEnabled = false
      self.present(alert, animated: true, completion: nil)
  }
  
  func textChanged(_ sender:UITextField) {
    if let enteredInt = Int(sender.text!) {
      self.actionToEnable?.isEnabled  = (enteredInt >= 1 && enteredInt <= 60)
    } else {
      self.actionToEnable?.isEnabled = false
    }
    
  }

}

