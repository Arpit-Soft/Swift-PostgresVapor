import Vapor

func routes(_ app: Application) throws {
    
    // /movies GET
    app.get("movies") { req in
        Movie.query(on: req.db).all()
    }
    
    // /movies/id GET
    app.get("movies",":movieId") { req -> EventLoopFuture<Movie>  in
        Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // /movies POST
    app.post("movies") { req -> EventLoopFuture<Movie> in
        let movie = try req.content.decode(Movie.self) // content = body of the request
        return movie.create(on: req.db).map { movie }
    }
    
    // /movies PUT
    app.put("movies") { req -> EventLoopFuture<HTTPStatus> in
        let movie = try req.content.decode(Movie.self)
        return Movie.find(movie.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // /movies/id DELETE
    app.delete("movies", ":movieId") { req -> EventLoopFuture<HTTPStatus> in
        Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
                    .transform(to: .ok)
            }
    }
    
    // /movies with Reviews GET
    app.get("movies_reviews") { req in
        Movie.query(on: req.db).with(\.$reviews).all()
    }
    
    // /reviews POST
    app.post("reviews") { req -> EventLoopFuture<Review> in
        let review = try req.content.decode(Review.self) // content = body of the request
        return review.create(on: req.db).map { review }
    }
}
