//
//  OMDAPI.swift
//  Boxotop


import Foundation


class OMDAPI : ObservableObject{
    
    @Published var results = [Movie]()
    @Published  var result = Movie(
        Title: "",
        Year: "",
        Poster : "",
        imdbID : "",
        TypeMovie :""
      )
    
    @Published var reponse = true
    @Published var etat = "erreur"
    func loadMoviesById(id: String) {
       
        self.etat = "erreur"
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=25d305b9") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject
                     
                        
                        
                        let movieName     = myJson["Title"]
                        let movieYear     = myJson["Year"]
                        let movieRuntime  = myJson["Runtime"]
                        let movieGenre  = myJson["Genre"]
                        let movieDirector  = myJson["Director"]
                        let movieWriter  = myJson["Writer"]
                        let movieActors = myJson["Actors"]
                        let moviePlot  = myJson["Plot"]
                        let movieLanguage  = myJson["Language"]
                        let movieCountry  = myJson["Country"]
                        let movieAwards  = myJson["Awards"]
                        let moviePoster  = myJson["Poster"]
                        let movieMetascore  = myJson["Metascore"]
                        let movieImdbRating  = myJson["imdbRating"]
                        let movieImdbVotes  = myJson["imdbVotes"]
                        let movieimdbID  = myJson["imdbID"]
                        let movieType     = myJson["Type"]
                        let movieDVD  = myJson["DVD"]
                        let movieBoxOffice  = myJson["BoxOffice"]
                        let movieProduction  = myJson["Production"]
                        let movieProductions  = myJson["Productions"]
                        let movieWebsite  = myJson["Website"]
                        let movieResponse = myJson["Response"]
                        
        
                        
                        
                        self.result = Movie(
                            Title: movieName as! String,
                            Year: movieYear as! String,
                            Runtime : movieRuntime as! String,
                            Genre: movieGenre as! String,
                            Director: movieDirector as! String,
                            Writer: movieWriter as! String,
                            Actors: movieActors as! String,
                            Plot : moviePlot as! String,
                            Language : movieLanguage as! String,
                            Country : movieCountry as! String,
                            Awards : movieAwards as! String,
                            Poster : moviePoster as! String,
                            Metascore: movieMetascore as! String,
                            imdbRating: movieImdbRating as! String,
                            imdbVotes: movieImdbVotes as! String,
                            imdbID : movieimdbID as! String,
                            TypeMovie :movieType as! String,
                          
                            
                            Response: movieResponse as! String
                        )
                        
                        
                            
                        self.etat = "succes"
                    }
                    catch
                    {
                        print("error in JSONSerialization")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    func loadMovies(title: String) {
      
        self.etat = "erreur"
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(title)&apikey=25d305b9") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                    
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject

                        if let search = myJson["Search"] as? [NSDictionary]
                        {
                            for result in search {
                                print(result["Title"]!)
                                print(result["Type"]!)
                                print(result["Poster"]!)
                                print(result["Year"]!)
                                
                                let movieName     = result["Title"]
                                let movieYear     = result["Year"]
                                let moviePoster  = result["Poster"]
                                let movieimdbID  = result["imdbID"]
                                let movieType     = result["Type"]
                               
                                
                                self.results.append(
                                    Movie(
                                        Title: movieName as! String,
                                        Year: movieYear as! String,
                                        Poster : moviePoster as! String,
                                        imdbID : movieimdbID as! String,
                                        TypeMovie :movieType as! String
                                        
                                      )
                                       
                                        )
                                
            
                            }
                            self.etat = "succes"
                        }else{
                            var response = myJson["Response"]
                            
                            if response as! String == "true"{
                                self.reponse = true
                            }else{
                                self.reponse = false
                            }
                            
                        }
                    }
                    catch
                    {
                        print("error in JSONSerialization")
                    }
                }
            }
        }
        task.resume()
    }
    
    
}
