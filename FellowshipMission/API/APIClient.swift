//
//  APIClient.swift
//  FellowshipMission
//
//  Created by Akinsete Sunday on 11/21/17.
//  Copyright © 2017 FMC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration

class APIClient: NSObject {
    
    func taskForGetMethod(path: String,completionHandlerForGET: @escaping (_ parsedResponse: AnyObject?, _ error: NSError?) -> Void) {
        func sendError(error: String) {
            let userInfo = [NSLocalizedDescriptionKey : error]
            completionHandlerForGET(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
        }
        
        
        let headers = [
//            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
//            "Authorization": "Bearer " + token
        ]
        

        Alamofire.request(APIClient.Constant.BaseURL + path, method: .get, parameters: nil,headers: headers).responseJSON { (response) in
            if(response.result.isFailure){
                sendError(error: "There was an error with your request")
                return
            }
            
            if(response.result.isSuccess){
                if let jsonObject = response.result.value {
                    let json = JSON(jsonObject)
                    completionHandlerForGET(json as AnyObject?,nil)
                }else{
                    sendError(error: "Unable to parse response")
                    return
                }
            }
        }
    }
    
    
    class func sharedInstance() -> APIClient {
        struct Singleton {
            static var sharedInstance = APIClient()
        }
        return Singleton.sharedInstance
    }
    
}


