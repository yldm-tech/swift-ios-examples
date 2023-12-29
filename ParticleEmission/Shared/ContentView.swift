//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 31/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View {
    
    @State var wish = false
    // Finish Wishes..
    @State var finshWish = false
    
    var body: some View{
        
        ZStack {
            
            VStack(spacing: 30){
                
                Image("cake")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: getRect().width / 1.8)
                
                Text("Happy Birthday\niJustine")
                    // Custom Font...
                    .font(.custom("Limelight-Regular", size: 35))
                    // LetterSpacing...
                    .kerning(3)
                    // Line Spacing...
                    .lineSpacing(10.0)
                    // TextColor..
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                
                Button(action: doAnimation, label: {
                    Text("Wish")
                        .kerning(2)
                        .font(.custom("Limelight-Regular", size: 15))
                        .padding(.vertical,12)
                        .padding(.horizontal,50)
                        .background(Color.purple)
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                })
                .disabled(wish)
                
            }
            
            EmitterView()
                .scaleEffect(wish ? 1 : 0, anchor: .top)
                .opacity(wish && !finshWish ? 1 : 0)
                // Moving From Center Effect...
                .offset(y: wish ? 0 : getRect().height / 2)
                .ignoresSafeArea()
        }
    }
    
    func doAnimation(){
        
        withAnimation(.spring()){
            
            wish = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            withAnimation(.easeInOut(duration: 1.5)){
                finshWish = true
            }
            
            // Resetting After Wish Finished...
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                finshWish = false
                wish = false
            }
        }
    }
}

// Global Function for getting Size...
func getRect()->CGRect{
    return UIScreen.main.bounds
}

// Emit Particle View...
// AKA CAEmmiterLayer from UIKit...
struct EmitterView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        // Emitter Layer...
        let emitterLayer = CAEmitterLayer()
        // Since we need top to down animation....
        // it;s your Own Wish...
        // Just change and play with properties.....
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmiterCells()
        
        // Size And Postion...
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createEmiterCells()->[CAEmitterCell]{
        
        // Multiple Differect Shped Emmiters....
        
        var emitterCells: [CAEmitterCell] = []
        
        for index in 1...12{
            
            let cell = CAEmitterCell()
            
            // Import White Particle Images...
            // Other wise color wont Work....
            cell.contents = UIImage(named: getImage(index: index))?.cgImage
            cell.color = getColor().cgColor
            // New Partcle Creation...
            cell.birthRate = 4.5
            // Particle Existence....
            cell.lifetime = 20
            // Velocity...
            cell.velocity = 120
            // Scale..
            cell.scale = 0.2
            cell.scaleRange = 0.3
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            
            // Accleartion...
            cell.yAcceleration = 40
            
            emitterCells.append(cell)
        }
        
        return emitterCells
    }
    
    func getColor()->UIColor{
        let colors : [UIColor] = [.systemPink,.systemGreen,.systemRed,.systemOrange,.systemPurple]
        
        return colors.randomElement()!
    }
    
    func getImage(index: Int)->String{
        
        if index < 4{
            return "rectangle"
        }
        else if index > 5 && index <= 8{
            return "circle"
        }
        else{
            return "triangle"
        }
    }
}
