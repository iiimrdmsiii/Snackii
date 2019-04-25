//
//  VendingMachineCollectionViewCell.swift
//  Snackii
//
//  Created by Makay Chapple on 4/19/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class VendingMachineCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
        // set up constraints for image
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
    
    func updateCell(snack: Snack) {
        imageView.image = UIImage(named: snack.image)
    }
}
