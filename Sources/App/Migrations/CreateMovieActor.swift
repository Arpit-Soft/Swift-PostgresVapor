//
//  CreateMovieActor.swift
//  
//
//  Created by Arpit Dixit on 09/09/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovieActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors") // table name
            .id()
            .field("movie_id", .uuid, .required, .references("movies", "id"))
            .field("actor_id", .uuid, .required, .references("actors", "id"))
            .create()
    }
    
    // Undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors").delete() // drop the table
    }
}
