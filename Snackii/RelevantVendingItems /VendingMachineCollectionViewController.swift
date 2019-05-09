//
//  VendingMachineCollectionViewController.swift
//  Snackii
//
//  Created by Makay Chapple on 4/19/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class VendingMachineCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 20
        (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 20
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
    
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.height = 200
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width = 150
        
        self.collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        let ref = Database.database().reference()
        
        ref.child("login/aNM7ng4zeENV2EkWkRQkUtvZEOg1").observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? [String: Any]
            let dataString = String(describing: data)
            print("\(dataString) \(dataString) \(dataString) \(dataString) \(dataString) \(dataString) \(dataString) \(dataString) \(dataString) ")
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        VendingMachineCollectionViewCell
        //cell.updateCell(snack: _)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let snack = snacks[indexPath.item]
        //print(snack.name)
    }

}
