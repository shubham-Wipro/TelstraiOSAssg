//
//  DataDesignModel.swift
//  TelstraPOC
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import Foundation

class jsonModel: Codable{
    let title: String?
    var rows: [dataRows]
}
class dataRows: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}
