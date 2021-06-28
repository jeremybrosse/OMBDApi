//
//  DetailMovie.swift
//  Boxotop

import SwiftUI

struct DetailMovie: View {
    
    @ObservedObject var donneesApi = OMDAPI()
    @Binding var openDetail : Bool
   
    var id : String
    var body: some View {

        VStack{
            
            VStack{
                ZStack{
                    
                    if self.donneesApi.result.Poster.count > 0{
                AsyncImage(
                    url: self.donneesApi.result.Poster,
                    placeholder: { Text("Loading ...") },
                    image: { Image(uiImage: $0).resizable() }
                ).frame(maxWidth: 400, minHeight: 500)
                    }else{
                        LottieView(animation: "search", autoriverse: false).frame(width: 200, height: 200)
                    }
                    VStack{
                        Text("")
                    }.frame(maxWidth: 400, minHeight: 500).background(Color.black.opacity(0.5))
                    HStack{
                    Image(systemName: "chevron.left.square.fill") .resizable().frame(width: 35, height: 35).foregroundColor(Color("ColorPrimary")).onTapGesture {
                        self.openDetail = false
                    }.padding(.leading, 20)
                        Spacer()
                     
                    }.frame(maxWidth: 400, maxHeight: 650, alignment: .top).padding(.top, 50)
                }.edgesIgnoringSafeArea(.top)
                ScrollView{
                    HStack{
                        Text("\(self.donneesApi.result.Title)").foregroundColor(Color.black).font(.system(size: 20))
                            .fontWeight(.bold).padding(.leading, 20)
                        
                        Text(" / \(self.donneesApi.result.Year)").foregroundColor(Color("ColorPrimary")).font(.system(size: 15)).fontWeight(.bold)
                    }.frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                    VStack{
                        
                        HStack{
                        Text("Résumé").foregroundColor(Color.black).font(.system(size: 10))
                            .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                          
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        
                    Text("\(self.donneesApi.result.Plot)")
                    }.frame(maxWidth: .infinity, minHeight: 150,alignment: .leading).padding().background(Color("ColorPrimary").opacity(0.2
                    )).cornerRadius(5).padding(.horizontal, 20)
                    
                    VStack{
                        
                        HStack{
                        Text("\(self.donneesApi.result.TypeMovie)").foregroundColor(Color.black).font(.system(size: 10))
                            .fontWeight(.bold).padding(2).background(Color.red.opacity(0.4)).cornerRadius(5)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                        
                        HStack{
                        Text("Note : \(self.donneesApi.result.imdbRating)" )
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        HStack{
                           
                            ForEach(0..<10){ item in
                                if rattingBar(number : self.donneesApi.result.imdbRating , item: item){
                                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).foregroundColor(Color.yellow)
                                }else{
                                    Image(systemName: "star.fill").resizable().frame(width: 12, height: 12)
                                }
                                
                            }
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        HStack{
                            
                        Text("Audience : \(self.donneesApi.result.imdbVotes)" )
                            Image(systemName: "person.3.fill")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                    }.padding(.horizontal, 20)
                    
                    VStack{
                        HStack{
                        Text("Acteurs").foregroundColor(Color.black).font(.system(size: 8))
                            .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        HStack{
                    Text("\(self.donneesApi.result.Actors)").font(.system(size: 10))
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.horizontal, 20)
                    
                    
                    
                    VStack{
                        HStack{
                        Text("Producteurs").foregroundColor(Color.black).font(.system(size: 8))
                            .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        HStack{
                    Text("\(self.donneesApi.result.Director)").font(.system(size: 10))
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.horizontal, 20)
                    
                    
                    VStack{
                        HStack{
                        Text("Auteurs").foregroundColor(Color.black).font(.system(size: 8))
                            .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        HStack{
                    Text("\(self.donneesApi.result.Writer)").font(.system(size: 10))
                        }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                    }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.horizontal, 20)
                    
                        
                        VStack{
                            HStack{//globe
                            Text("Langues").foregroundColor(Color.black).font(.system(size: 8))
                                .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                                Image(systemName: "globe").resizable().frame(width: 12, height: 14).foregroundColor(Color.black).padding(.bottom, 5)
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                            HStack{
                        Text("\(self.donneesApi.result.Language)").font(.system(size: 10))
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.horizontal, 20)
                
                        VStack{
                            HStack{
                               
                                Text("Récompenses").foregroundColor(Color.black).font(.system(size: 8))
                                    .fontWeight(.bold).padding(2).background(Color("ColorPrimary")).cornerRadius(5)
                                Image(systemName: "rosette").resizable().frame(width: 12, height: 14).foregroundColor(Color.black).padding(.bottom, 5)
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                            HStack{
                        Text("\(self.donneesApi.result.Awards)").font(.system(size: 10))
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                        }.frame(maxWidth: .infinity, alignment: .leading).padding().padding(.horizontal, 20)
          
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
         
                
               
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)
        }.edgesIgnoringSafeArea(.top).onAppear{
            self.donneesApi.loadMoviesById(id: id)
        }
    }
}



