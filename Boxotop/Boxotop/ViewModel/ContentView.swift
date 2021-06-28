//
//  ContentView.swift
//  Boxotop
//


import SwiftUI



struct ContentView: View {
    
    
    @ObservedObject var donneesApi = OMDAPI()
    @State var valeurRecherche = ""
    @State var callPopUpSearch = false
    @State var openDetail = false
    @State var openDetailListe = false
    @State var id = ""
    @State var selectedType = 1
  
    
    var body: some View {
        
        ZStack{
            if self.openDetailListe{
                DetailMovieListe(openDetail: self.$openDetailListe, id: self.id )
            }else if self.openDetail{
                DetailMovie(openDetail: self.$openDetail, id: self.id )
            }else{
                if self.donneesApi.etat == "succes"{
                HomeView(valeurRecherche: self.$valeurRecherche, callPopUpSearch: self.$callPopUpSearch, selectedType: self.$selectedType, donneesApi: self.donneesApi, id : self.$id , openDetail: self.$openDetail, openDetailListe: self.$openDetailListe)
                }else{
                    if !self.donneesApi.reponse{
                        Text("Aucun film ne correspond à votre recherche").foregroundColor(Color("ColorPrimary")).font(.system(size: 20))
                            .fontWeight(.bold).padding(.top, 50).padding(.horizontal, 40)
                        LottieView(animation: "search", autoriverse: false).frame(width: 200, height: 200)
                    }else{
                    Text("Trouves ton film avec Box Office !").foregroundColor(Color("ColorPrimary")).font(.system(size: 20))
                        .fontWeight(.bold).padding(.top, 50).padding(.horizontal, 40)
                    LottieView(animation: "search", autoriverse: false).frame(width: 200, height: 200)
                    }
                }
            }
            
          
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("ColorPrimary")).onAppear{
            self.donneesApi.loadMovies(title : "iron")
        }
    }
    
   
}



