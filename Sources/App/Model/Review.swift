//
//  Review.swift
//  
//
//  Created by Arpit Dixit on 08/09/21.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver


final class Review: Model, Content {
    
    static let schema = "reviews"
    
    @ID(key: .id) // Primary key
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "rating")
    var rating: Int
    
    // Belongs To - belongs to a particular movie
    @Parent(key: "movie_id") // Foreign key
    var movie: Movie
    
    init() {}
    
    init(id: UUID? = nil, title: String, description: String, rating: Int, movieId: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.rating = rating
        self.$movie.id = movieId
    }
}
