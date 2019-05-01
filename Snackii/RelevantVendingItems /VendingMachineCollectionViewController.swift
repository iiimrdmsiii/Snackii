//
//  VendingMachineCollectionViewController.swift
//  Snackii
//
//  Created by Makay Chapple on 4/19/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class VendingMachineCollectionViewController: UICollectionViewController {
    var snacks: [Snack] = [Snack(name: "Pepsi", imageID: "2000px-Pepsi_logo_2014.svg"), Snack(name: "Lays", imageID: "250px-Mid_products_lays.svg")]

    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 20
        (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 20
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 40, bottom: 20, right: 40)
    
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.height = 200
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize.width = 150
        
        self.collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snacks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        VendingMachineCollectionViewCell
        
        cell.updateCell(snack: snacks[indexPath.item])
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snack = snacks[indexPath.item]
        print(snack.name)
    }

}
