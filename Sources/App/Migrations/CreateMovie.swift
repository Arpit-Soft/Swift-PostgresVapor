//
//  CreateMovie.swift
//  
//
//  Created by Arpit Dixit on 08/09/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies") // table name
            .id()
            .field("title", .string) // column name
            .create()
    }
    
    // Undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
}
