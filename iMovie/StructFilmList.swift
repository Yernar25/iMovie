//
//  StructPopular.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 27.11.2024.
//

import Foundation
import SwiftyJSON

struct FilmList {
    var title = ""
    var poster_path = ""
    var release_date = ""
    var vote_average = 0.0
    var id = 0
    
    init (json: JSON) {
        if let item = json["title"].string {
            title = item
        }
        
        if let item = json["poster_path"].string{
            poster_path = item
        }
        
        if let item = json["release_date"].string{
            release_date = item
        }
        
        if let item = json["vote_average"].double{
            vote_average = item
        }
        
        if let item = json["id"].int{
            id = item
        }
    }
}
