//
//  MovieActor.swift
//  
//
//  Created by Arpit Dixit on 09/09/21.
//

import Foundation
import Vapor
import Fluent

// Pivot tale between actor and Movies for creating many to many relation
final class MovieActor: Model, Content {
    
    static let schema = "movie_actors"
    
    @ID(key: .id) // Primary key
    var id: UUID?
    
    @Parent(key: "movie_id") // Foreign key
    var movie: Movie
    
    @Parent(key: "actor_id") // Foreign key
    var actor: Actor
    
    init() {}
    
    init(movieId: UUID, actorId: UUID) {
        self.$movie.id = movieId
        self.$actor.id = actorId
    }
}
