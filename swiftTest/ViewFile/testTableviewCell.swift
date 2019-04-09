//
//  testTableviewCell.swift
//  swiftTest
//
//  Created by LiuJianning on 2019/3/27.
//  Copyright © 2019 ljn. All rights reserved.
//

import UIKit

class testTableviewCell: UITableViewCell {

    let imageView_W = 120//w:h = 4:3
    let imageView_H = 90
    let subView_interval:CGFloat = 10
    
    var leftImageView : UIImageView?
    var nameLabel     : UILabel!
    var subNameLabel  : UILabel?
    var timeLabel     : UILabel?
    var browseLabel   : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        self.createCellUI()
    }
    
    fileprivate func createCellUI(){
        
        leftImageView = UIImageView.init(frame : CGRect(x:5, y:5, width:imageView_W,height:imageView_H))
        leftImageView!.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(leftImageView!)
        leftImageView?.image = UIImage(named: "twotabbarimg-unselect.jpg")
        
//        name
        nameLabel = UILabel.init(frame: CGRect(x: (leftImageView?.left)!, y: (leftImageView?.bottom)!+20, width: 100, height: 20) )
        nameLabel?.textColor = UIColor.darkText
        nameLabel?.backgroundColor = UIColor.purple
        nameLabel?.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(nameLabel!)


    }
    
    //MARK:刷新cell数据
    func reloadCellData(model:testModel) {
        
        nameLabel.text = model.categoryName
        leftImageView?.imageUrl(urlStr:  model.image ?? "")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
