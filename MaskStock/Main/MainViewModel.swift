//
//  MainViewModel.swift
//  MaskStock
//
//  Created by 윤병진 on 2020/05/31.
//  Copyright © 2020 darkKnight. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    var model : BehaviorRelay<MainModel?> = BehaviorRelay<MainModel?>(value: nil)
    var responseError : BehaviorRelay<String> = BehaviorRelay(value: "")
    var storesAddr : BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    func request() {
        let parameters : [String : String] = ["address" : storesAddr.value!]
        
        Api.MainRequest(parameters, completionHandler: { responseData in
            if responseData is Data {
                let responseData : Data = responseData as! Data
                let json : MainModel? = try? JSONDecoder().decode(MainModel.self, from: responseData)
                self.model.accept(json)
                
            } else {
                let responseError = responseData as? Error
                self.responseError.accept(responseError.debugDescription)
            }
        })
    }
}
