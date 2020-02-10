//
//  NetworkManager.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import UIKit

typealias completionHandler = (Any?, HTTPURLResponse?, Error?) -> Void

final class NetworkManager: NSObject {

    static let defaultManager = NetworkManager()
    
    private override init() {
    }
    
    func fetchDataFrom(_ urlString: String, _ completionBlock: @escaping completionHandler){
        guard let url = URL(string: urlString) else{
            let error = ErrorHandler.createError(code: ErrorCodes.urlConversionFailure.rawValue, description: "Api Call Failed")
            completionBlock(nil, nil, error)
            return
        }
        let getData = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else{
                completionBlock(nil, nil, error)
                return
            }
            let resp = response as? HTTPURLResponse
            if data != nil{
                let (parsedData, parsingError) = ParsingHelper.parseData(data!)
                if parsedData != nil{
                    completionBlock(parsedData, resp, parsingError)
                }else{
                    completionBlock(nil, resp, parsingError)
                }
            }else{
                let noDataFound = ErrorHandler.createError(code: ErrorCodes.dataNotFound.rawValue, description: "No Data Found")
                completionBlock(nil, resp, noDataFound)
            }
        }
        getData.resume()
    }
}
