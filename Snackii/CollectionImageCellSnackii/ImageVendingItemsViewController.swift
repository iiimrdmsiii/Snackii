//
//  ImageVendingItemsViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/27/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class ImageVendingItemsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //*********************************************************
    // MARK: - Properties
    //*********************************************************
    
    let dispatchGroup = DispatchGroup()
    
    var docRef: DocumentReference!
    
    var db: Firestore!
    
    var imageCellsCollectionView: ImageVendingItemsViewController?

    var snacks = [Snack]()

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
            snacks.append(Snack(name: "", imageID: "", image: selectedImage))
            dismiss(animated: true, completion: nil)
            
            self.snackiiCollectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Will save the images and upload it up to firebase
    @IBAction func saveImagesButtonItemTapped(_ sender: Any) {
        
        // alert if there are no Image
        if snacks.isEmpty {
            
            let alertImage = UIAlertController(title: "Picture", message: "Please add a photo", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertImage.addAction(action)
            
            alertImage.popoverPresentationController?.sourceView = sender as? UIView
            
            present(alertImage, animated: true, completion: nil)
            
        } else {
        
            // runs the image to save up to firebase.
            // upload image to fb
            for snack in snacks {
                if let image = snack.image {
                    uploadFirebaseImages(image) { (url) in
                        guard let url = url else {
                            print("the url returned was nil")
                            return
                        }
                        self.saveImageToFirebase(snackName: snack.name, snackiiImagesURL: url, completion: { success in
//                            self.firebaseWrite(url: url.absoluteString)
                            
                            // able to go to next UIview.
                            self.performSegue(withIdentifier: "saveSnackImages", sender: self)
                        })
                    }
                }
            }
        }
    }
    
    //*********************************************************
    // MARK: - Database Cloud FireStore
    //*********************************************************

    
    
    
    //*********************************************************
    // MARK: - Overrides and Methods
    //*********************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.purple

        snackiiCollectionView.reloadData()
        
        db = Firestore.firestore()
        
        docRef = db.document("snacks/uid/")

    }
    
    // Upload the image to Firebase
    func uploadFirebaseImages(_ image: UIImage, completion: @escaping ((_ url: URL?) -> () )) {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("uid could not be found")
            return
        }
//        let uid = "dSMAbsP07kVSu5lmG2R55qg9Orz2"
        
        let storageRef = Storage.storage().reference().child("snack/\(uid)/\(UUID().uuidString)")
        
        
        guard let imageData = image.jpegData(compressionQuality: 0.25) else {
            print("image could not be compressed")
            return
        }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if error == nil, metaData != nil {
                
                // Success
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
                
            } else {
                // Fail
                print("there was an error putting the data to storage")
                completion(nil)
            }
        }
    }
    
    // Save the images to firebase
    func saveImageToFirebase(snackName: String, snackiiImagesURL: URL, completion: @escaping((_ success: Bool) -> ())) {
        print("SaveImageToFirebase has been saved!!!!!")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Firestore.firestore().document("snacks/\(UUID().uuidString)")
        
        let userObjectImages = [
            "uid": uid,
            "imageURL": snackiiImagesURL.absoluteString,
            "name": snackName
        ] as [String:String]
        
        databaseRef.setData(userObjectImages) { (error) in
            if let error = error {
                print(error.localizedDescription)
                print("There was an error setting data to database")
            }
            completion(error == nil)
        }
    }
    
    // Add a new document with a generated ID
    // url String helps with creating a string for the image to have a place that the image can me saved.
//    private func firebaseWrite(url: String) {
//        var ref: DocumentReference? = nil
//        ref = db.collection("snacks").addDocument(data: [
//            "imageURL": url
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//
//        db.collection("snacks").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let storage = Storage.storage()
        let storageRef = storage.reference()

//        let downloadURL = snacks[indexPath.row]
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let uid = "dSMAbsP07kVSu5lmG2R55qg9Orz2"
        
        let storageDelete = storageRef.child("snack/\(uid)/")
        
        let index = 0
        collectionView.allowsMultipleSelection = true
    
        if !(itemSelected.contains(indexPath)) {
            itemSelected.append(indexPath)
            snacks.remove(at: index)
            
            storageDelete.delete {
                error in
                if let error = error {
                    print("Oh no!!! it has an issue with: \(error)")
                } else {
                    print("File deleted succefully")
                }
            }
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
        
        cell.snackiiImagesViews.image = snacks[indexPath.item].image
        cell.delegate = self
        
        return cell
    }
    
    
    // this doesnt interact with anything right now.
//    func handleSave() {
//
//        guard let image = collectionCellImage?.snackiiImagesViews.image else { return }
//
//        // Upload the profile image to Firebase Storage
//        self.uploadFirebaseImages(image) { url in
//
//            if let url = url {
//                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//
//                changeRequest?.photoURL = url
//
//                // write ther string of the image
//                self.firebaseWrite(url: url.absoluteString)
//
//                changeRequest?.commitChanges { error in
//                    if error == nil {
//                        print("image Display change")
//
//                        // save the image data to firebase database
//                        self.saveImageToFirebase(snackName: "", snackiiImagesURL: url ){ success in
//                            if success {
//                                self.dismiss(animated: true, completion: nil)
//                            } else {
//                                self.restForm()
//                            }
//                        }
//                    } else {
//                        print("Error: \(error!.localizedDescription)")
//                        self.restForm()
//                    }
//                }
//
//
//            } else {
//                self.restForm()
//            }
//        }
//
//    }
//
//    // catches the error to alert you for signing up.
//    func restForm() {
//
//        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
//    }
}

// helps write and print it on the iphone screen.
extension ImageVendingItemsViewController: ImageCellsCollectionViewCellDelegate {
    func nameTextFieldDidUpdate(text: String, cell: ImageCellsCollectionViewCell) {
        
        // to update the snack the array you need to know the index of the item that you're editing.
        // you also need to know the name of the snack (what the user typed in)
        guard let index = snackiiCollectionView.indexPath(for: cell) else { return }
//        snacks[index.row].name = text
    }
}
