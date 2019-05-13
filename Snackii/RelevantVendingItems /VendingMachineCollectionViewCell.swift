//
//  VendingMachineCollectionViewCell.swift
//  Snackii
//
//  Created by Makay Chapple on 4/19/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase

class VendingMachineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
        self.imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    func storagePull(/*imageString: String*/) {
        Storage.storage().reference(withPath:"snack/0E638614-08D7-43A4-BEB8-2BE936BE21EC"
            ).getData(maxSize: (1024 * 1024), completion: { (data, error) in
                guard let data = data,
                    let image = UIImage(data: data) else { return }
                self.imageView.image = image
            })
    }
    func updateCell(snack: Snack) {
        imageView.image = UIImage(named: snack.imageID)
        storagePull()
    }
}
