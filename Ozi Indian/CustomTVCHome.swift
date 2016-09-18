//
//  CustomTVCHome.swift
//  Ozi Indian
//
//  Created by Gurpreet on 14/09/16.
//  Copyright © 2016 Amanpreet Singh. All rights reserved.
//

import UIKit

class CustomTVCHome: UITableViewCell {

    //HomeVC
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    //MenuVC
    @IBOutlet weak var lblMenuCategories: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
