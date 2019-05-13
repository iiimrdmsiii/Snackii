//
//  VendingMachineCollectionViewController.swift
//  Snackii
//
//  Created by Hayden Hoki on 4/19/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class VendingMachineCollectionViewController: UICollectionViewController {

    var dataString: String = ""
    var url: URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/snackii.appspot.com/o/snack%2FrA8BLix1tSPtHw0mSGwGmsqzmp43%2F6E9BCE6C-5AFF-4728-AB04-63B81247F229?alt=media&token=30f4d738-47ca-48e4-8ae5-356d884d09de")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        
//        collectionViewInitializer()
//        initializeFirebaseData()
//        imagesOrSomething(url: url)
//        updateSnackiiImages(from: url)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as!
        VendingMachineCollectionViewCell
        
//        cell.updateCell(snack: )
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let snack = snacks[indexPath.item]
//        print(snack.name)
    }
    
    // MARK: - Initializing Functions for 'ViewDidLoad'
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func updateSnackiiImages(from url: URL) {
        print("Start Download images")
        getData(from: url) {data, response, error in
            guard let data = data, error == nil else {return}
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Finished download")
            print("\(data)")
        }
    }
    func imagesOrSomething(url: URL) {
        getData(from: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("\(data)")
        }
    }
    
    
    

}
