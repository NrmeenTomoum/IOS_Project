//
//  File.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 4/29/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import Foundation
class Movie {
    var title :String?
    var image :String?
    var rating : Float?
    var releaseYear : Int?
    var genre :[String]
    init( title :String?, image :String?, rating : Float?,releaseYear : Int?,genre :[String])
    {
        self.title=title
        self.image=image
        self.rating=rating
        self.releaseYear=releaseYear
        self.genre=genre
    }
    
}