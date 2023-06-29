//
//  ListViewController.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var infoModel = UserInfoViewModel()
    var userModel = UserInfoModel()
    var users : [User]?
    
    var activityView = UIActivityIndicatorView()
    
    var limit:Int? = 10
    var countIsZero = false
    
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView = UIActivityIndicatorView(style: .large)
        self.view.addSubview(activityView)
        activityView.frame = self.view.frame
        
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.getUserInfoAPI()
    }
}
extension ListViewController {
    func registerTableViewCells() {
        let textCell = UINib(nibName: "ListViewCell",
                             bundle: nil)
        self.listTableView.register(textCell,
                                    forCellReuseIdentifier: "ListViewCell")
        
        self.listTableView.tableFooterView = UIView()
        self.activityIndicator = LoadMoreActivityIndicator(scrollView: listTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
    func getUserInfoAPI() {
        if Connectivity.isConnectedToInternet() {
            let params = [:] as [String : Any]
            DispatchQueue.main.async {
                self.activityView.startAnimating()
            }
            infoModel.getUserInfoRequest(params: params, urlStr: "https://dummyjson.com/users?limit=\(String(describing: limit!))&skip=0")  { (error) in
                if error == nil {
                    self.activityView.stopAnimating()
                    if (self.infoModel.userInfo?.users?.count ?? 0) > 0 {
                        self.userModel = self.infoModel.userInfo!
                        if self.limit == 10 {
                            self.users = self.userModel.users!
                        }
                        else if self.limit != 10 {
                            self.users?.removeAll()
                            self.users = self.users! + self.userModel.users!
                        }
                    }
                    DispatchQueue.main.async {
                        self.listTableView.reloadData()
                    }
                }
                else {
                    self.activityView.stopAnimating()
                    print("Session Expired")
                }
                self.activityView.stopAnimating()
            }
        }
        else {
            print("No Internet Connection")
        }
    }
}
extension ListViewController : UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.users?.count)
        return self.users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :ListViewCell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        cell.userImg.addShadowPath(view: cell.listView)
        if self.users!.count > 0 {
            cell.userLbl.text = (self.users?[indexPath.row].firstName ?? "") + " " + (self.users?[indexPath.row].maidenName ?? "")
            cell.descLbl.text = (self.users?[indexPath.row].address?.city ?? "") + " , " + (self.users?[indexPath.row].address?.state ?? "")
            cell.desc1Lbl.text = (self.users?[indexPath.row].company?.title ?? "") + " - " + (self.users?[indexPath.row].company?.department ?? "")
            cell.userImg.kf.setImage(with: URL(string: self.users![indexPath.item].image ?? ""), placeholder:  UIImage(named:"user.png"))
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if countIsZero == true {
            return
        }
        activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                self.limit = self.limit! + 10
                self.getUserInfoAPI()
                sleep(3)
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stop()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.users!.count > 0 {
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.userId = self.users?[indexPath.row].id
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

