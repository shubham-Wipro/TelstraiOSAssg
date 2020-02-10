//
//  ParsingHelper.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation
import UIKit

class ParsingHelper: NSObject{
     class func parseData(_ data: Data) -> (jsonModel?, Error?){
            guard let dataString = String(data: data, encoding: .isoLatin1) else{
                let error = ErrorHandler.createError(code: ErrorCodes.dataConversionError.rawValue,description: "Parsing Error")
                return(nil, error)
            }
            if let data = dataString.data(using: .utf8){
                do{
                    let obj = try JSONDecoder().decode(jsonModel.self, from: data)
                    obj.rows = obj.rows.filter({ (row) -> Bool in
                        if row.description == nil && row.title == nil && row.imageHref == nil {
                            return false
                        }
                        return true
                    })
                    return(obj, nil)
                }catch{
                    let error = ErrorHandler.createError(code: ErrorCodes.dataConversionError.rawValue,description: "Parsing Error")
                    return(nil, error)
                }
            }
            return(nil,nil)
        }
}
