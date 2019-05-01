//
//  ImageCellsCollectionViewCell.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/28/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

protocol ImageCellsCollectionViewCellDelegate: class {
    func nameTextFieldDidUpdate(text: String, cell: ImageCellsCollectionViewCell)
}

class ImageCellsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ImageCellsCollectionViewCellDelegate?
    
    @IBOutlet weak var snackiiImagesViews: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        nameTextField.delegate = self
    }
}

extension ImageCellsCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.nameTextFieldDidUpdate(text: textField.text ?? "", cell: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.nameTextFieldDidUpdate(text: textField.text ?? "", cell: self)
        return true
    }
}
