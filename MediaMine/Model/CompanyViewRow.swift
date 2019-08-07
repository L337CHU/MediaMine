//
//  CompanyViewRow.swift
//  MediaMine
//
//  Created by Amy Stockinger on 8/6/19.
//  Copyright © 2019 Amy Stockinger. All rights reserved.
//

import Foundation

struct CompanyViewRow : Decodable{
    let id:String
    let created_time:String
    let predicted_impressions_count:String
    let price:String
}
