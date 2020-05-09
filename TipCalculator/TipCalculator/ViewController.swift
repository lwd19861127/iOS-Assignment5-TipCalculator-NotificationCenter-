//
//  ViewController.swift
//  TipCalculator
//
//  Created by mac on 2020/5/9.
//  Copyright © 2020 Don. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    var tip: Double = 0
    var tipPercentage: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        billAmountTextField.placeholder = "Please input Bill Amount"
        billAmountTextField.text = "100"
        
        tipPercentageTextField.keyboardType = UIKeyboardType.numberPad
        tipPercentageTextField.text = "15"
        
        tipPercentageSlider.isContinuous = false
        tipPercentageSlider.minimumValue = 0
        tipPercentageSlider.maximumValue = 100
        tipPercentageSlider.value = 15
        
        billAmountTextField.delegate = self
        tipPercentageTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        tipPercentageTextField.text = String(Int(tipPercentageSlider.value))
        calculate()
    }
    @IBAction func calculateTip(_ sender: UIButton) {
        calculate()
    }
    
    private func calculate(){
        tip = Double(billAmountTextField.text!)! * Double(tipPercentageTextField.text!)!/100
        tipAmountLabel.text = String(tip)
    }
    
    @objc func dismissKeyboard(_ recogizer: UITapGestureRecognizer) {
        billAmountTextField.resignFirstResponder()
        tipPercentageTextField.resignFirstResponder()
        tipPercentage = Double(tipPercentageTextField.text!)!
        tipPercentageSlider.value = Float(tipPercentage)
        calculate()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
      // change the view frame (y) (moves up)
      // 1. get the keyboard size (height)
      // 2. change view.frame.origin.y
      if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if view.frame.origin.y == 0 {
          view.frame.origin.y -= keyboardSize.height / 2
        }
      }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
      if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        if view.frame.origin.y != 0 {
          view.frame.origin.y = 0
        }
      }
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
