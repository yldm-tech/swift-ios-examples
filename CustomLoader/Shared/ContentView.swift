//
//  ContentView.swift
//  Shared
//
//  Created by Balaji on 16/03/21.
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
    
    // Animation Properties...
    @State var offsets: [CGSize] = Array(repeating: .zero, count: 3)
    
    // static offsets for one full complete rotation....
    
    // So after One complete roatation it will again fire animation
    // for that were going to use Timer...
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    
    @State var delayTime: Double = 0
    
    var locations: [CGSize] = [
    
        // rotation1
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: -110, height: 0),
        // rotation 2
        CGSize(width: 110, height: 110),
        CGSize(width: 110, height: -110),
        CGSize(width: -110, height: -110),
        // rotation3
        CGSize(width: 0, height: 110),
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        // final resetting rotation....
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0)
    ]
    
    var body: some View{
        
        ZStack{
            
            Color("bg")
                .ignoresSafeArea()
            
            // Loader View....
            VStack(spacing: 10){
                
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color("box1"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[0])
                }
                // with spacing 100+100+10....
                .frame(width: 210, alignment: .leading)
                
                HStack(spacing: 10){
                    
                    Rectangle()
                        .fill(Color("box2"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[1])
                    
                    Rectangle()
                        .fill(Color("box3"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[2])
                }
            }
        }
        .onAppear(perform: doAnimation)
        .onReceive(timer, perform: { _ in
            // resetting timer...
            print("reDo Animation")
            delayTime = 0
            doAnimation()
        })
    }
    
    func doAnimation(){
        
        // doing our animation here.....
        
        // since we have three offsets so were going to convert this array to subarrays of max three elements...
        // you can directly declare as subarrays....
        // Im doing like this its your choice....
        
        var tempOffsets: [[CGSize]] = []
        
        var currentSet: [CGSize] = []
        
        for value in locations{
            
            currentSet.append(value)
            
            if currentSet.count == 3{
                // appending to main array...
                tempOffsets.append(currentSet)
                // clearing...
                currentSet.removeAll()
            }
        }
        
        // checking if any inclomplete array...
        if !currentSet.isEmpty{
            
            tempOffsets.append(currentSet)
            currentSet.removeAll()
        }
        
        // Animation...
        
        for offset in tempOffsets{
            
            for index in offset.indices{
                
                // each box shift will take 0.5 sec to finish...
                // so delay will be 0.3 and its multiplies ......
                doAnimation(delay: .now() + delayTime, value: offset[index], index: index)
                delayTime += 0.3
            }
        }
    }
    
    func doAnimation(delay: DispatchTime,value: CGSize,index: Int){
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            withAnimation(Animation.easeInOut(duration: 0.5)){
                self.offsets[index] = value
            }
        }
    }
}

// just cancel timer when new page open or closed.....
