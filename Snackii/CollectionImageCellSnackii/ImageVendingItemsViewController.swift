//
//  ImageVendingItemsViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/27/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import UIKit

class ImageVendingItemsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    var snackiiImage: SnackiiImage?
    
    var imageCellsCollectionView: ImageVendingItemsViewController?
    
    let snackii = [""]
 
    var snackiiImages = [UIImage]()
    
    var imagePicker: UIImagePickerController!
    
    var collectionCellImage: ImageCellsCollectionViewCell?
    
    var itemSelected = [IndexPath]()
    
    
    //*********************************************************
    // MARK: - Outlets
    //*********************************************************
    

    @IBOutlet weak var snackiiCollectionView: UICollectionView!
    @IBOutlet weak var addImageButtonItem: UIBarButtonItem!
    @IBOutlet weak var saveImagesButtonItem: UIBarButtonItem!
    
    //*********************************************************
    // MARK: - Actions
    //*********************************************************
    
    // alert buttons when tapped addImageFromPhoto
    @IBAction func addImageFromPhoto(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    // Image picking functionality - When a user want to pick image's they will recive an alert notification of the want to use the Library or not.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            collectionCellImage?.snackiiImagesViews.image = selectedImage
            snackiiImage?.imageData = selectedImage.pngData()
            snackiiImages.append(selectedImage)
            dismiss(animated: true, completion: nil)
            
            self.snackiiCollectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveImagesButtonItemTapped(_ sender: Any) {
        
        
        
    }
    
    
    //*********************************************************
    // MARK: - Overrides and Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()

        snackiiCollectionView.reloadData()

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snackiiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = 0
        snackiiImages.remove(at: index)
        collectionView.allowsMultipleSelection = true
        
    
        if !(itemSelected.contains(indexPath)) {
            itemSelected.append(indexPath)
        }
        
        let alert = UIAlertController(title: "Delete Alert", message: "Are you sure you want to delete this image?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { (_) in
            collectionView.deleteItems(at: [indexPath])
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCellsCollectionViewCell
        
        cell.snackiiImagesViews.image = snackiiImages[indexPath.item]
        
        
        return cell
    }
    
    func deleteItem() {
        
        collectionCellImage?.snackiiImagesViews.delete(Any?.self)
    }
    
}
