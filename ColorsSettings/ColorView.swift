//
//  MainViewController.swift
//  ColorsSettings
//
//  Created by Anton Akhmedzyanov on 23.08.2023.
//

import UIKit

protocol SettingColorViewControllerDelegate {
    func setColorView( for myView: UIColor )
}

class ColorView: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setVC = segue.destination as? SettingColorViewController else { return}
        setVC.delegate = self
        setVC.color = view.backgroundColor
    }
}

extension ColorView: SettingColorViewControllerDelegate {
    func setColorView(for myView: UIColor) {
        view.backgroundColor = myView
    }
    
    
}
