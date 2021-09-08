//
//  CreateReview.swift
//  
//
//  Created by Arpit Dixit on 08/09/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateReview: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews") // table name
            .id()
            .field("title", .string) // column name
            .field("description", .string)
            .field("rating", .int)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    
    // Undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete() // drop the table
    }
}
