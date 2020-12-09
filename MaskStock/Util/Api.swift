//
//  Api.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias CompletionHandler = (Any)->()
typealias CompletionHandlerData = (Data)->()

func enCode(_ data : Data) -> String? {
    return String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))) ?? ""
}

private func responseDataEncoding(_ data : Data) -> Data {
    let eucKrEncodingString = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))) ?? ""
    return Data(eucKrEncodingString.utf8)
}


struct Api {
    // MARK: - SMSCertification
    static func MainRequest(_ parameters : [String : String], completionHandler : @escaping(CompletionHandler)) {
        AF.request(Url.storesByAddr, method: .get, parameters: parameters).responseData { response in
            switch response.result {
            case .success :
                guard let data = response.data else {
                    return
                }
                print("JSON(data): \(JSON(data))")
                completionHandler(data)
            case .failure(let error) :
                completionHandler(error)
            }
        }
    }
}
