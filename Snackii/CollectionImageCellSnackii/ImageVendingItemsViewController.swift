//
//  ImageVendingItemsViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/27/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class ImageVendingItemsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var snackiiImage: SnackiiImage?
    var imageCellsCollectionView: ImageVendingItemsViewController?
    
    let snackii = [""]
 
    let snackiiImages = [UIImage]()
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    

    @IBOutlet weak var snackiiCollectionView: UICollectionView!
    @IBOutlet weak var addImageButtonItem: UIBarButtonItem!
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    @IBAction func addImageFromPhoto(_ sender: Any) {
        
        
        
    }
    

    //*********************************************************
    // MARK: - Overrides and Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snackiiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let snackiiImage = cell.viewWithTag(1000) as? UIImageView {
            snackiiImage.image = snackiiImages[indexPath.item]
    }
        
        return cell
}
    
    
    // Managed the Images on Snackii
    func updateView() {
        
        guard let image = snackiiImage else {return}
        if let imageData = image.imageData,
            let images = UIImage(data: imageData) {
            
            
            
        }
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        snackiiImages.insert(image, at: 0)
        collectionView?.reloadData()
    }
}
