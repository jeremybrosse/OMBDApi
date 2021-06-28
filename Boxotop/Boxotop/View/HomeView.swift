//
//  HomeView.swift
//  Boxotop


import SwiftUI

struct HomeView: View {
    
    @Binding var valeurRecherche: String
    @Binding var callPopUpSearch : Bool 
    private let Types = ["rectangle.grid.1x2", "square.grid.2x2"]
    @Binding var selectedType : Int
    var donneesApi : OMDAPI
    @Binding var id : String
    @Binding var openDetail : Bool
    @Binding var openDetailListe : Bool
    @State var item = -1
    
    
    var body: some View {
        Color("ColorPrimary")
            .edgesIgnoringSafeArea(.top)

        VStack{
            
            HStack{
                
                Image("")
                Text("Box office") .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                TextField("Cherche ton film", text: self.$valeurRecherche)
                    .keyboardType(.emailAddress)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(20).onTapGesture {
                        self.callPopUpSearch = true
                    }
            }.frame(maxWidth: .infinity, maxHeight: 50).padding(.horizontal, 20).background(Color("ColorPrimary"))
            
            
     
            VStack{
                
                
                Picker(selection: $selectedType, label: Text("")) {
                        ForEach(0 ..< Types.count) {
                            Image(systemName: "\(self.Types[$0])")
                           
                        }
                }.pickerStyle(SegmentedPickerStyle()).background(Color.white).padding(.top, 15).padding(.horizontal, 20)
                
                if self.Types[self.selectedType] == "square.grid.2x2"{
                    ScrollView{
                        
                        if self.donneesApi.results.count > 0{
                            ForEach(self.donneesApi.results, id: \.Title){ item in

                                
                                ZStack() {
                                   
                                    AsyncImage(
                                        url: item.Poster,
                                        placeholder: { Text("Loading ...") },
                                        image: { Image(uiImage: $0).resizable() }
                                    ).frame(maxWidth: 400, maxHeight: 450)
                                   
                                    
                                    VStack{
                                        Text("")
                                    }.frame(maxWidth: 400, maxHeight: 450).background(Color.black.opacity(0.65))
                                    Text(item.Title)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(.top, 50)
                                    
                                    Text(item.TypeMovie).font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                
                                }.frame(maxWidth: .infinity, maxHeight: 450).cornerRadius(20).padding(.horizontal, 30).padding(.vertical, 20).onTapGesture{
                                    
                                    self.id = item.imdbID
                                    self.openDetail = true
                                
                                }.shadow(color: Color.black.opacity(0.8), radius: 10, x: 5, y: 4)
                            }
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
                }else{
                    ScrollView{
                        
                        if self.donneesApi.results.count > 0{
                            ForEach(0..<self.donneesApi.results.count){ item in
                                
                                VStack(spacing: 0) {
                                   
                                    HStack{
                                        Text(self.donneesApi.results[item].Title)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        
                                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading ).padding(.leading, 20)
                                
                                }.frame(maxWidth: .infinity, minHeight: 80, alignment: .leading ).background((item  % 2 == 0) ? Color("white") : Color("ColorPrimary").opacity(0.3)).onTapGesture{
                                    
                                    self.id = self.donneesApi.results[item].imdbID
                             
                                    self.openDetailListe = true
                                  
                                }.onAppear{
                                    self.item += 1
                                }
                                   
                                
                            }
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
                }
                
               
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)
        }
        
        if self.callPopUpSearch {
            
            HStack{
                Text("")
            } .frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.8))
            BoiteDeDialogue(
                largeur: UIScreen.main.bounds.width * 0.70,
                hauteur: UIScreen.main.bounds.height * 0.40,
                afficher: self.$callPopUpSearch,
                titre: "Rechercher un film",
                couleurTitre: .white,
                couleurBackgroundTitre: Color("ColorPrimary"),
                texteBoutonFermeture: "Quitter",
                iconeTitre: nil,
                avecBoutonValidation: true,
                texteBoutonValidation: "Valider",
                actionBoutonValidation: {
                  
                    self.donneesApi.results.removeAll()
                    self.donneesApi.loadMovies(title: "\(self.valeurRecherche)")
                  
            }) {
                VStack(alignment: HorizontalAlignment.leading, spacing: 6) {
                    Text("Recherche")
                        .font(.subheadline)
                    TextField("Search", text: self.$valeurRecherche)
                       
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                                .shadow(radius: 10)
                    )
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .animation(.easeOut(duration: 0.5))
        }
    }
    func verifColor(item: Int) -> String{
        
        var retour : String = ""
        self.item = self.item + 1
        
        
        if item % 2 == 0{
            retour = "ColorPrimary"
        }else{
            retour = "white"
        }
        
        
        return retour
        
    }    
}

