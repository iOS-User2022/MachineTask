//
//  ServiceHandler.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import Foundation
import Alamofire

class ServiceHandler {
    static func fetchResponse(_ type: String, _ method: HTTPMethod, _ params: [String: Any]?, _ urlPath: String, token: String, showLoader: Bool = true, completion: @escaping (_ response: Data?, _ error: String?) -> Void) {
        if Connectivity.isConnectedToInternet() {
            print("------API Start------ \(type)")
            
            print("URL:", "\(urlPath)\(urlPath)")
            print("Parameters:",params as AnyObject)
            AF.request("\(urlPath)", method: method, parameters: params, headers: nil).responseJSON { (response) in
                if response.error == nil {
                    print(response.result)
                    print("Result Response", response.result)
                    switch response.result {
                    case .failure(let error):
                        print("\(type) Response", response)
                        print("------API End------ \(type)\n\n\n\n")
                        completion(nil, error.localizedDescription)
                    case .success(_):
                        print("\(type) Response", response)
                        print("------API End------ \(type)\n\n\n\n")
                        completion(response.data, nil)
                    }
                } else {
                    completion(nil, response.error?.localizedDescription ?? "")
                    print("\(type) Response", response)
                    print("------API End------ \(type)\n\n\n\n")
                }
            }
        } else {
            completion(nil,"No Internet")
        }
    }
}
