//
//  Mydelegat.swift
//  Movie_Demo
//
//  Created by Nrmeen Tomoum on 4/30/16.
//  Copyright © 2016 Nrmeen Tomoum. All rights reserved.
//

import Foundation
import CoreData
protocol Mydelegat {
    func addMovieDelegate(movie : NSManagedObject)
    func addMovieDelegate(movie : Movie)
}