//
//  ViewController.swift
//  ColorsSettings
//
//  Created by Anton Akhmedzyanov on 23.08.2023.
//

import UIKit

final class SettingColorViewController: UIViewController {

    @IBOutlet var mainView: UIImageView!
    
    @IBOutlet var redIndexLabel: UILabel!
    @IBOutlet var greenIndexLabel: UILabel!
    @IBOutlet var blueIndexLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var color: UIColor!
    var delegate: SettingColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = color
        mainView.layer.cornerRadius = 15
        setSliderColor()
        setValue(for: redSlider, greenSlider, blueSlider)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //MARK: - @IBAction func

    @IBAction func setColor(_ sender: UISlider) {
        setColors()
        setIndex()
        setTF()
    }
    
    @IBAction func pressedDone() {
        delegate.setColorView(for: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    //MARK: - Private funcs
    
    private func setValue(for sliders: UISlider...) {
        let ciColor = CIColor(color: color)
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(ciColor.red)
                setIndex()
                setTF()
            case greenSlider:
                greenSlider.value = Float(ciColor.green)
                setIndex()
                setTF()
            default:
                blueSlider.value = Float(ciColor.blue)
                setIndex()
                setTF()
            }
        }
    }
    private func setColors() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)

    }
    
    private func setSliderColor() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }
    
    private func setIndex() {
        redIndexLabel.text = String(format: "%.2f", redSlider.value)
        greenIndexLabel.text = String(format: "%.2f", greenSlider.value)
        blueIndexLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setTF() {
        redTF.text = redIndexLabel.text
        greenTF.text = greenIndexLabel.text
        blueTF.text = blueIndexLabel.text
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

extension SettingColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }
        guard let newValue = Float(value) else { return }
        
        if newValue < 1.01 {
            
            switch textField {
            case redTF:
                redSlider.value =  newValue
                setIndex()
                setColors()
            case greenTF:
                greenSlider.value =  newValue
                setIndex()
                setColors()
            case blueTF:
                blueSlider.value =  newValue
                setIndex()
                setColors()
            default:
                break
            }
        } else {
            showAlert(with: "Attention!", and: "Shold be untill one")
            switch textField {
            case redTF:
                setTF()
            case greenTF:
                setTF()
            case blueTF:
                setTF()
            default:
                break
            }
            
        }
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            let keyboardToolbar = UIToolbar()
            keyboardToolbar.sizeToFit()
            textField.inputAccessoryView = keyboardToolbar
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(didTapDone)
            )
            
            let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                             target: nil,
                                             action: nil)
            
            keyboardToolbar.items = [flexButton, doneButton]
            
        }
    }

