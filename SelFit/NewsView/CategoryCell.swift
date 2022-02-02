//
//  CategoryCell.swift
//  SelFit
//
//  Created by Reathan Luo on 2/2/22.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var newSourceCategoryColor: UIImageView!
    @IBOutlet weak var newsSourceCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabelName: UILabel!
    @IBOutlet weak var imageViewTest: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 9
        // To indicate category color
        newSourceCategoryColor.layer.masksToBounds = true
        newSourceCategoryColor.layer.cornerRadius  = newSourceCategoryColor.frame.width/2
    }
    
}
