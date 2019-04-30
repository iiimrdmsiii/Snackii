//
//  SettingViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 4/22/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var addAndSaveImagesIsHidden: ImageVendingItemsViewController?
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    
    @IBOutlet weak var onOrOffSwitch: UISwitch!
    
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    @IBAction func adminSwitch(_ sender: UISwitch) {
        addAndSaveImagesIsHidden?.addImageButtonItem.isEnabled = onOrOffSwitch.isOn
        addAndSaveImagesIsHidden?.saveImagesButtonItem.isEnabled = onOrOffSwitch.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onOrOffSwitch.isOn = addAndSaveImagesIsHidden?.addImageButtonItem.isEnabled ?? false
    }
}
