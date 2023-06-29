//
//  DetailViewController.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userDetailLbl: UILabel!
    
    @IBOutlet weak var userImgView: UIImageView!
    
    var userId:Int? = 0
    
    var infoModel = UserInfoViewModel()
    var userDetailModel : UserInfoDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.getUserDetailAPI()
    }
}
extension DetailViewController {
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DetailViewController {
    func getUserDetailAPI() {
        if Connectivity.isConnectedToInternet() {
            let params = [:] as [String : Any]
            infoModel.getUserDetailRequest(params: params, urlStr: "https://dummyjson.com/users/\(String(describing: userId!))")  { (error) in
                if error == nil {
                    self.userDetailModel = self.infoModel.userModel!
                    if self.userDetailModel != nil {
                        self.userImgView.layer.cornerRadius = 4.0
                        self.userImgView.layer.borderColor = UIColor.lightGray.cgColor
                        self.userImgView.layer.borderWidth = 0.4
                        self.userImgView.layer.cornerRadius = self.userImgView.frame.height/2
                        self.userImgView.layer.masksToBounds = false
                        self.userImgView.clipsToBounds = true
                        
                        self.userImgView.kf.setImage(with: URL(string: self.userDetailModel?.image ?? ""), placeholder:  UIImage(named:"user.png"))
                        self.userDetailLbl.text =
                        "Name : " + "\n" + "\(self.userDetailModel?.firstName ?? "")" + " " + "\(self.userDetailModel?.lastName ?? "")" +
                        "\n\n" +
                        "Age : " + "\n" + "\(self.userDetailModel?.age ?? 0)" +
                        "\n\n" +
                        "Gender : " + "\n" + "\(self.userDetailModel?.gender ?? "")" +
                        "\n\n" +
                        "Phone : " + "\n" + "\(self.userDetailModel?.phone ?? "")" +
                        "\n\n" +
                        "BirthDate : " + "\n" + "\(self.userDetailModel?.birthDate ?? "")" +
                        "\n\n" +
                        "Blood Group : " + "\n" + "\(self.userDetailModel?.bloodGroup ?? "")" +
                        "\n\n" +
                        "Eye Color : " + "\n" + "\(self.userDetailModel?.eyeColor ?? "")" +
                        "\n\n" +
                        "Hair Color and Type: " + "\n" + "\(self.userDetailModel?.hair?.color ?? "")" + " , " + "\(self.userDetailModel?.hair?.type ?? "")" +
                        "\n\n" +
                        "Id : " + "\n" + "\(self.userDetailModel?.id ?? 0)" +
                        "\n\n" +
                        "Address : " + "\n" + "\(self.userDetailModel?.address?.address ?? "")" + " , " + "\(self.userDetailModel?.address?.city ?? "")" + " , " + "\(self.userDetailModel?.address?.state ?? "")" + " , " + "\(self.userDetailModel?.address?.postalCode ?? "")" +
                        "\n\n" +
                        "Currency : " + "\n" + "\(self.userDetailModel?.bank?.currency ?? "")" +
                        "\n\n" +
                        "University : " + "\n" + "\(self.userDetailModel?.university ?? "")" +
                        "\n\n" +
                        "Company Address: " + "\n" + "\(self.userDetailModel?.company?.address?.address ?? "")" + " , " + "\(self.userDetailModel?.company?.address?.city ?? "")" + " , " + "\(self.userDetailModel?.company?.address?.state ?? "")" + " , " + "\(self.userDetailModel?.company?.address?.postalCode ?? "")" +
                        "\n\n" +
                        "User Company Detail: " + "\n" + "\(self.userDetailModel?.company?.name ?? "")" + " , " + "\(self.userDetailModel?.company?.title ?? "")" + " , " + "\(self.userDetailModel?.company?.department ?? "")"

                    }
                }
                else {
                    print("Session Expired")
                }
            }
        }
        else {
            print("No Internet Connection")
        }
    }
    
}
