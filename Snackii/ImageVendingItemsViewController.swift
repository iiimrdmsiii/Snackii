//
//  ImageVendingItemsViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/27/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class ImageVendingItemsViewController: UIViewController {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    
    
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    
    @IBOutlet weak var snackiiVendingItemsCollectionView: UICollectionView!
    @IBOutlet weak var addImageBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var snackiiImages: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = snackiiVendingItemsCollectionView.dequeueReusableCell(withReuseIdentifier: "snackiiImages", for: indexPath)
        
        return cell
    }
    
    


}

