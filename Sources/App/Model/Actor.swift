//
//  Actor.swift
//  
//
//  Created by Arpit Dixit on 09/09/21.
//

import Foundation
import Vapor
import Fluent

final class Actor: Model, Content {
    
    static let schema = "actors"
    
    @ID(key: .id) // Primary key
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    // Many to Many - Movie has many reviews
    @Siblings(through: MovieActor.self, from: \.$actor, to: \.$movie)
    var movies: [Movie]
    
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
