//
//  RememberCell.swift
//  Kioku
//
//  Created by Yuhao on 2017/06/01.
//  Copyright © 2017年 Yuhao. All rights reserved.
//

import UIKit

class RememberCell: UITableViewCell{
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var kanaLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    public var id: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
    
}
