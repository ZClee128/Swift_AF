//
//  ZCTools.swift
//  Weather
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 lzc. All rights reserved.
//

import UIKit

typealias CallBackSuccess = (AFHTTPRequestOperation!,AnyObject!) ->Void
typealias CallBackError = (AFHTTPRequestOperation!,NSError!) ->Void
class ZCTools: NSObject {
    
    var blockSuccess:CallBackSuccess!
    var blockError:CallBackError!

    class func afGetURl(url:String,parameter:NSDictionary?,blockSuccess:CallBackSuccess,blockError:CallBackError){
        ZCTools().getUrl(url, parameter: parameter, blockSuccess: blockSuccess, blockError: blockError)
    }
    
   private func getUrl(url:String,parameter:NSDictionary?,blockSuccess:CallBackSuccess,blockError:CallBackError){
        self.blockSuccess = blockSuccess
        self.blockError = blockError
        let man = AFHTTPRequestOperationManager()
    man.responseSerializer = AFHTTPResponseSerializer()
        man.GET(url, parameters: parameter, success: { (task, success) in
            
            self.blockSuccess(task,success)
            
        }) { (task, error) in
                self.blockError(task,error)
                    
        }
    }
}
