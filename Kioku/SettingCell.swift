//
//  SettingCell.swift
//  Kioku
//
//  Created by Yuhao on 2017/05/31.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell{
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var descriptionView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
