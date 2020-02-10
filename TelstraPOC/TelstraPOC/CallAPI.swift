//
//  CallAPI.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit
import Foundation

protocol CallApiDelegate: class {
    func didReceiveResponse(data: jsonModel?, code: Int?, error: Error?)
}

class CallAPI: NSObject {
    weak var delegate: CallApiDelegate?
    func dataRequest(fetchingUrl: String){
        NetworkManager.defaultManager.fetchDataFrom(fetchingUrl) { (data, response, error) in
            let responseCode = response?.statusCode
            self.delegate?.didReceiveResponse(data: data as? jsonModel, code: responseCode, error: error)
        }
    }
}
