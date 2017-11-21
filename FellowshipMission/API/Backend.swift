//
//  Backend.swift
//  FellowshipMission
//
//  Created by Akinsete Sunday on 11/21/17.
//  Copyright © 2017 FMC. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

extension Notification.Name {
    public static let AudioCompleted = Notification.Name(rawValue: "audio_fetched")
}

class Backend:APIClient{
    
    static let shared = Backend()
    let nc = NotificationCenter.default

    
    func fetchAudioMedia(){
        let path = Methods.Audio
        taskForGetMethod(path: path) { (parsedResponse, error) in
            var data:[String: AnyObject]!
            if(error != nil){
                data = ["status": false as AnyObject,"message":"Unable to fetch audio files" as AnyObject]
            }else{
                let json = parsedResponse as! JSON
                //print(json)
                
                let mediaObject = json["audio_files"]
                if(mediaObject != JSON.null){
                    //AudioMedia.query().fetch().removeAll()
                    let audios = Mapper<AudioMedia>().mapArray(JSONArray:mediaObject.arrayObject as! [[String : Any]])

                    Store.shared.audios = audios
//                    audios.forEach({ (audio) in
//                        if(audio.commit()){
//                            print(audio.getPath() + " Saved")
//                        }
//
//                    })
                }

                
                
                data = [
                    "status": json["status"].boolValue as AnyObject,
                    "message": json["message"].stringValue as AnyObject
                ]
            }
            NotificationCenter.default.post(name: .AudioCompleted, object: nil, userInfo: data)
        }
    }

}
