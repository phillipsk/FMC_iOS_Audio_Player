//
//  AudioMedia.swift
//  FellowshipMission
//
//  Created by Akinsete Sunday on 11/21/17.
//  Copyright © 2017 FMC. All rights reserved.
//

import Foundation
import ObjectMapper
import SharkORM


public class AudioMedia:SRKObject,Mappable {
    
    @objc dynamic public var name:String!
    @objc dynamic public var path:String!
    @objc dynamic public var time_created:String!;
    
    override init (){super.init()}
    
    required public init?(map: Map) { super.init()}
    
    public func mapping (map: Map){
        self.name <- map["name"];
        self.path <- map["path"];
        self.time_created <- map["time_created"];
    }
    
    
    //// getters ////
    
    func getName()->String{
        return self.name;
    }
    
    func getPath()->String{
        return self.path;
    }
    
    func getTime_created()->String{
        return self.time_created;
    }
    
    //// setters ////
    
    func setName(value:String){
        self.name = value;
    }
    
    func setPath(value:String){
        self.path = value;
    }
    
    func setTime_created(value:String){
        self.time_created = value;
    }
    
}
