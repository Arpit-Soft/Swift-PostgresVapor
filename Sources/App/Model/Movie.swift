//
//  Movie.swift
//  
//
//  Created by Arpit Dixit on 08/09/21.
//

import Foundation
import Vapor
import Fluent

final class Movie: Model, Content {
    
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
