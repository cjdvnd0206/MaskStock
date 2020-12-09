//
//  MainModel.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import Foundation

struct MainModel: Codable {
    
    var count : Int = 0
    var address = ""
    var stores : [MainModelInformations]?

    enum CodingKeys : String, CodingKey {
        case count = "count"
        case address = "address"
        case stores = "stores"
    }
    
    init(from decoder: Decoder) throws {
        let unkeyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        count = try unkeyedContainer.decode(Int.self, forKey : .count)
        address = try unkeyedContainer.decode(String.self, forKey : .address)
        stores = (try? unkeyedContainer.decode([MainModelInformations].self, forKey : .stores)) ?? []
    }
}

struct MainModelInformations: Codable {
    
    var stockAt : String = ""
    var latitude : Float = 0.0
    var code : String = ""
    var createdAt : String = ""
    var longitude : Float = 0.0
    var name : String = ""
    var remainStat : String = ""
    var address : String = ""
    var type : String = ""
    var typeDetail : String {
        switch type {
        case "01":
            return "약국"
        case "02":
            return "우체국"
        case "03":
            return "농협"
        default:
            return ""
        }
    }
    var remain : String {
        switch remainStat {
        case "plenty":
            return "100개 이상"
        case "some":
            return "30개 이상 100개 미만"
        case "few":
            return "30개 미만"
        case "empty":
            return "1개 미만"
        case "break":
            return "판매 중단"
        default:
            return ""
        }
    }
   
    enum CodingKeys : String, CodingKey {
        case stockAt = "stock_at"
        case latitude = "lat"
        case code = "code"
        case createdAt = "created_at"
        case longitude = "lng"
        case name = "name"
        case remainStat = "remain_stat"
        case address = "addr"
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        let unkeyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        stockAt = (try? unkeyedContainer.decode(String.self, forKey : .stockAt)) ?? ""
        latitude = (try? unkeyedContainer.decode(Float.self, forKey : .latitude)) ?? 0.0
        code = (try? unkeyedContainer.decode(String.self, forKey : .code)) ?? ""
        createdAt = (try? unkeyedContainer.decode(String.self, forKey : .createdAt)) ?? ""
        longitude = (try? unkeyedContainer.decode(Float.self, forKey : .longitude)) ?? 0.0
        name = (try? unkeyedContainer.decode(String.self, forKey : .name)) ?? ""
        remainStat = (try? unkeyedContainer.decode(String.self, forKey : .remainStat)) ?? ""
        address = (try? unkeyedContainer.decode(String.self, forKey : .address)) ?? ""
        type = (try? unkeyedContainer.decode(String.self, forKey : .type)) ?? ""
        
    }
}
