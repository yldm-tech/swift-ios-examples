//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 10/04/21.
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
    
    // Animation Parameters...
    @State var startAnimation = false
    
    @State var pulse1 = false
    @State var pulse2 = false
    
    // Found People...
    // Max People Will be 5
    // remiaing all shoing in bottomsheet...
    @State var foundPeople : [People] = []
    
    // Finish Animation..
    @State var finishAnimation = false
    
    var body: some View{
        
        VStack{
            
            // Nav Bar...
            HStack(spacing: 10){
                
                Button(action: {}, label: {
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.black)
                })
                
                Text( finishAnimation ? "\(peoples.count) people NearBy" : "NearBy Search")
                    .font(.title2)
                    .fontWeight(.bold)
                    .animation(.none)
                
                Spacer()
                
                Button(action: verifyAndAddPeople, label: {
                    
                    // showing refresh button if finish animation toggled..
                    if finishAnimation{
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    else{
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                    }
                })
                .animation(.none)
            }
            .padding()
            .padding(.top,getSafeArea().top)
            .background(Color.white)
            
            ZStack{
                
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse1 ? 3.3 : 0)
                    .opacity(pulse1 ? 0 : 1)
                
                Circle()
                    .stroke(Color.gray.opacity(0.6))
                    .frame(width: 130, height: 130)
                    .scaleEffect(pulse2 ? 3.3 : 0)
                    .opacity(pulse2 ? 0 : 1)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 130, height: 130)
                // Shadows..
                    .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                
                Circle()
                    .stroke(Color.blue,lineWidth: 1.4)
                    .frame(width: finishAnimation ? 70 : 30, height: finishAnimation ? 70 : 30)
                    .overlay(
                    
                        Image(systemName: "checkmark")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .opacity(finishAnimation ? 1 : 0)
                    )
                
                ZStack{
                    
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue,lineWidth: 1.4)
                    
                    Circle()
                        .trim(from: 0, to: 0.4)
                        .stroke(Color.blue,lineWidth: 1.4)
                        .rotationEffect(.init(degrees: -180))
                }
                .frame(width: 70, height: 70)
                // rotating view...
                .rotationEffect(.init(degrees: startAnimation ? 360 : 0))
                
                // showing found people..
                ForEach(foundPeople){people in
                    
                    Image(people.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(4)
                        .background(Color.white.clipShape(Circle()))
                        .offset(people.offset)
                }
            }
            .frame(maxHeight: .infinity)
            
            // Bottom Sheet...
            if finishAnimation{
                
                VStack {
                    
                    // Pull up indicator..
                    Capsule()
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: 50, height: 4)
                        .padding(.vertical,10)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        
                        HStack(spacing: 15){
                            
                            // Since were only locating first 5 people in pulse animation
                            // so show all peoples here....
                            ForEach(peoples){people in
                                
                                VStack(spacing: 15){
                                    
                                    Image(people.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    Text(people.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Button(action: {}, label: {
                                        Text("Choose")
                                            .fontWeight(.semibold)
                                            .padding(.vertical,10)
                                            .padding(.horizontal,40)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    })
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding()
                        .padding(.bottom,getSafeArea().bottom)
                    })
                }
                .background(Color.white)
                .cornerRadius(25)
                // bottom slide...
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
        .background(Color.black.opacity(0.05).ignoresSafeArea())
        .onAppear(perform: {
            animateView()
        })
    }
    
    func verifyAndAddPeople(){
        
        if foundPeople.count < 5{
            
            // adding people...
            withAnimation{
                var people = peoples[foundPeople.count]
                // setting custom offset for top five found people...
                people.offset = firstFiveOffsets[foundPeople.count]
                foundPeople.append(people)
            }
        }
        else{
         
            // finishing animation and showing bottom sheet...
            withAnimation(Animation.linear(duration: 0.6)){
                finishAnimation.toggle()
                
                //resetting all animation...
                startAnimation = false
                pulse1 = false
                pulse2 = false
            }
            
            // checking if animation finished...
            // if so resetting all..
            if !finishAnimation{
                withAnimation{foundPeople.removeAll()}
                animateView()
            }
        }
    }
    
    func animateView(){
        withAnimation(Animation.linear(duration: 1.7).repeatForever(autoreverses: false)){
            
            startAnimation.toggle()
        }
        
        // it will start next round 0.1s eariler....
        withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
            
            pulse1.toggle()
        }
        
        // 2nd pulse Animation...
        // will start 0.5 delay...
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
                
                pulse2.toggle()
            }
        }
    }
}

// extending View to get Safearea and screen Size...

extension View{
    
    func getSafeArea()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

// Sample People Model And Data...
struct People: Identifiable {
    
    var id = UUID().uuidString
    var image: String
    var name: String
    // Offset will be used for showing user in pulse animation....
    var offset: CGSize = CGSize(width: 0, height: 0)
}

var peoples = [

    People(image: "pic1", name: "iJustine"),
    People(image: "pic2", name: "Jenna Ezarik"),
    People(image: "pic3", name: "Tim"),
    People(image: "pic4", name: "Bill"),
    People(image: "pic5", name: "Jeff"),
]

// Random Offsets for top 5 people...
var firstFiveOffsets: [CGSize] = [

    // you can change the position of user views by changing the offsets here....
    CGSize(width: 100, height: 100),
    CGSize(width: -100, height: -100),
    CGSize(width: -50, height: 130),
    CGSize(width: 50, height: -130),
    CGSize(width: 120, height: -50),
]
