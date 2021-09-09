import Vapor

func routes(_ app: Application) throws {
    
    // /movies GET
    app.get("movies") { req in
        Movie.query(on: req.db).with(\.$reviews).with(\.$actors).all()
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
    
    // /reviews GET
    app.get("reviews") { req in
        Review.query(on: req.db).all()
    }
    
    // /reviews POST
    app.post("reviews") { req -> EventLoopFuture<Review> in
        let review = try req.content.decode(Review.self) // content = body of the request
        return review.create(on: req.db).map { review }
    }
    
    // /actors GET
    app.get("actors") { req in
        Actor.query(on: req.db).with(\.$movies).all()
    }
    
    // /movies POST
    app.post("actors") { req -> EventLoopFuture<Actor> in
        let actor = try req.content.decode(Actor.self) // content = body of the request
        return actor.create(on: req.db).map { actor }
    }
    
    // /movies/movieId/actor/actorId POST
    app.post("movie", ":movieId", "actor", ":actorId") { req -> EventLoopFuture<HTTPStatus> in
        
        let movie = Movie.find(req.parameters.get("movieId"), on: req.db).unwrap(or: Abort(.notFound))
        let actor = Actor.find(req.parameters.get("actorId"), on: req.db).unwrap(or: Abort(.notFound))
        
        return movie.and(actor).flatMap { (movie, actor) in
            movie.$actors.attach(actor, on: req.db)
                .transform(to: .ok)
        }
    }
}
