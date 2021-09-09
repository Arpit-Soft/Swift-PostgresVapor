//
//  CreateActor.swift
//  
//
//  Created by Arpit Dixit on 09/09/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors") // table name
            .id()
            .field("name", .string) // column name
            .create()
    }
    
    // Undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors").delete() // drop the table
    }
}
