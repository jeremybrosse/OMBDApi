//
//  LottieView.swift
//  Boxotop
//


import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
   
    var animation : String
    var autoriverse : Bool
    init(animation : String, autoriverse : Bool) {
        self.animation = animation
        self.autoriverse = autoriverse
    }
    
    
    typealias UIViewType = UIView
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        let animation = Animation.named("\(self.animation)")
        
     
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        
        if self.autoriverse{
          animationView.loopMode = .autoReverse
            
        }else{
            animationView.loopMode = .loop
        }
        
        animationView.forceDisplayUpdate()
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
                
        ])
        
 
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }

}
