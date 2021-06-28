//
//  BoiteDeDialogue.swift
//  Boxotop

import SwiftUI


import SwiftUI

struct BoiteDeDialogue<Content>: View where Content: View {
    var largeur: CGFloat
    var hauteur: CGFloat
    @Binding var afficher: Bool
    var titre: String
    var couleurTitre: Color
    var couleurBackgroundTitre: Color
    var texteBoutonFermeture: String
    var iconeTitre: String?
    var avecBoutonValidation: Bool?
    var texteBoutonValidation: String?
    var actionBoutonValidation: (() -> Void)?
    var contenu: Content
    
    init(
        largeur: CGFloat,
        hauteur: CGFloat,
        afficher: Binding<Bool>,
        titre: String,
        couleurTitre: Color,
        couleurBackgroundTitre: Color,
        texteBoutonFermeture: String,
        iconeTitre: String?,
        avecBoutonValidation: Bool?,
        texteBoutonValidation: String?,
        actionBoutonValidation: (() -> Void)?,
        @ViewBuilder contenu: @escaping () -> Content
        ) {
        self.largeur = largeur
        self.hauteur = hauteur
        self._afficher = afficher
        self.titre = titre
        self.couleurTitre = couleurTitre
        self.couleurBackgroundTitre = couleurBackgroundTitre
        self.texteBoutonFermeture = texteBoutonFermeture
        self.iconeTitre = iconeTitre
        self.avecBoutonValidation = avecBoutonValidation
        self.texteBoutonValidation = texteBoutonValidation
        self.actionBoutonValidation = actionBoutonValidation
        self.contenu = contenu()
    }
    var body: some View {
        VStack {
            HStack {
                if iconeTitre != nil {
                    Image(systemName: iconeTitre!)
                }
                
                Text(titre)
                    .foregroundColor(couleurTitre)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .padding(.horizontal)
                    .background(couleurBackgroundTitre)
            }
            
            ScrollView {
                contenu
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
          
            HStack(spacing: 30) {
                Spacer()
                Button(action: {
                    self.afficher.toggle()
                }) {
                    Text(texteBoutonFermeture)
                        .foregroundColor(couleurBackgroundTitre)
                        .font(.system(size: 20, weight: .medium))
                }
                
                if self.avecBoutonValidation != nil && self.texteBoutonValidation != nil && self.actionBoutonValidation != nil {
                    Button(action: {
                        self.afficher.toggle()
                        self.actionBoutonValidation!()
                    }) {
                        Text(texteBoutonValidation!)
                            .foregroundColor(couleurBackgroundTitre)
                            .font(.system(size: 20, weight: .medium))
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom)
        }
        .frame(width: largeur, height: hauteur, alignment: .center)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 10)
    }
}

