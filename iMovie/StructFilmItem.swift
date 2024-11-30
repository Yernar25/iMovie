//
//  StructFilmItem.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 27.11.2024.
//

import Foundation
import SwiftyJSON

struct FilmItem {
    var title = ""
    var posterPath = ""
    var releaseDate = ""
    var voteAverage = 0.0
    var tagline = ""
    var overview = ""
    
    
    init (json: JSON) {
       
        if let item = json["title"].string {
            title = item
        }
        
        if let item = json["backdrop_path"].string{
            posterPath = item
        }
        
        if let item = json["release_date"].string{
            releaseDate = item
        }
        
        if let item = json["vote_average"].double{
            voteAverage = item
        }
        
        if let item = json["tagline"].string{
            tagline = item
        }
        
        if let item = json["overview"].string{
            overview = item
        }
    }
}
