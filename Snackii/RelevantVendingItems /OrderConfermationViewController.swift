//
//  OrderConfermationViewController.swift
//  Snackii
//
//  Created by Makay Chapple on 4/26/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class OrderConfermationViewController: UIViewController {
    @IBAction func orderButtonPressed(_ sender: Any) {
        let alert = UIAlertController.init(title: "Confirm?", message: "Confirm?", preferredStyle: .alert)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
