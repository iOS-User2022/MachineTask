//
//  ListViewCell.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var desc1Lbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var listView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension UIView {
    
    func addShadowPath(view:UIView) {
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        if #available(iOS 13.0, *) {
            if UserDefaults.standard.bool(forKey: "darkMode") == true //this works only in app
                || UITraitCollection.current.userInterfaceStyle == .dark
            {
                view.backgroundColor = UIColor.clear
            }
            else
            {
                view.backgroundColor = UIColor.white
                view.layer.shadowColor = UIColor.lightGray.cgColor
            }
        } else {
            // Fallback on earlier versions
        }
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 2.0
        view.layer.masksToBounds = false
    }
}
