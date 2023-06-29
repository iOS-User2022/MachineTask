//
//  UserInfoViewModel.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import Foundation

class UserInfoViewModel {
    var userInfo : UserInfoModel?
    var userModel : UserInfoDetail?
}
extension UserInfoViewModel {
    func getUserInfoRequest(params: [String: Any], urlStr: String, completion: @escaping (_ errorString: String?) -> Void) {
        ServiceHandler.fetchResponse("User Info", .get, params, urlStr, token: "") { (response, error) in
            if error == nil {
                do {
                    if response != nil {
                        let decoded = try JSONDecoder().decode(UserInfoModel.self, from: response!)
                        self.userInfo = decoded
                        completion(nil)
                    } else {
                        completion("User Info API")
                    }
                } catch let decodeError {
                    let err = decodeError.localizedDescription.replacingOccurrences(of: "’", with: "'")
                    completion("User Info API:\n\(err)")
                    print("err:\(err)")
                    print("decodeError:\(decodeError)")
                }
            }
            else {
                completion(error ?? "")
            }
        }
    }
    func getUserDetailRequest(params: [String: Any], urlStr: String, completion: @escaping (_ errorString: String?) -> Void) {
        ServiceHandler.fetchResponse("User Info Detail", .get, params, urlStr, token: "") { (response, error) in
            if error == nil {
                do {
                    if response != nil {
                        let decoded = try JSONDecoder().decode(UserInfoDetail.self, from: response!)
                        self.userModel = decoded
                        completion(nil)
                    } else {
                        completion("User Info Detail API")
                    }
                } catch let decodeError {
                    let err = decodeError.localizedDescription.replacingOccurrences(of: "’", with: "'")
                    completion("User Info Detail API:\n\(err)")
                    print("err:\(err)")
                    print("decodeError:\(decodeError)")
                }
            }
            else {
                completion(error ?? "")
            }
        }
    }
}
