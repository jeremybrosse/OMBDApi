//
//  MovieModel.swift
//  Boxotop
//


import Foundation


struct Response: Codable {
    var results: [Movie]
}

struct Movie: Codable, Identifiable {
    var id = UUID()
    var Title: String
    var Year: String
    var Runtime : String = ""
    var Genre : String = ""
    var Director : String = ""
    var Writer : String = ""
    var Actors : String = ""
    var Plot : String = ""
    var Language : String = ""
    var Country : String = ""
    var Awards : String = ""
    var Poster : String = ""
    var Metascore : String = ""
    var imdbRating : String = ""
    var imdbVotes : String = ""
    var imdbID : String = ""
    var TypeMovie : String = ""
    var DVD : String = ""
    var BoxOffice : String = ""
    var Production : String = ""
    var Productions : String = ""
    var Website : String = ""
   var Response : String = ""
    
}
