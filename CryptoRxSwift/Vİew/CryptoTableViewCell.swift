//
//  CryptoTableViewCell.swift
//  CryptoRxSwift
//
//  Created by Atil Samancioglu on 18.12.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    public var item: Crypto! {
           didSet {
               self.nameLabel.text = item.currency
               self.priceLabel.text = item.price

           }
       }
    

}

