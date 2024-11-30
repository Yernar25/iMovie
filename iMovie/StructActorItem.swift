//
//  StructActor.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 29.11.2024.
//

import Foundation
import SwiftyJSON

struct ActorItem {
    var name = ""
    var profilePath = ""
    var character = ""
    
    init (json: JSON) {
        if let item = json["name"].string {
            name = item
        }
        
        if let item = json["profile_path"].string {
            profilePath = item
        }
        
        if let item = json["character"].string {
            character = item
        }
    }
}
