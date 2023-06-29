//
//  Connectivity.swift
//  MachineTask
//
//  Created by Djax on 29/06/23.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
