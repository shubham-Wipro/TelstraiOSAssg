//
//  ErrorHandler.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

enum ErrorCodes: Int {
    case dataConversionError = 8000
    case parsingError = 8001
    case urlConversionFailure = 8002
    case errorInNetworkCall = 8003
    case dataNotFound = 8004
}

class ErrorHandler: NSObject {
    class func createError(code:Int, description:String) -> Error {
        return NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: description]) as Error
    }
}


