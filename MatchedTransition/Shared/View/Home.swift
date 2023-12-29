//
//  Home.swift
//  MatchedTransition (iOS)
//
//  Created by Balaji on 20/05/21.
//

import SwiftUI

// Extending View to get Screen Size...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

struct Home: View {
    
    // NameSpace For Animation...
    @Namespace var animation
    
    @StateObject var animationModel = AnimationViewModel()
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{proxy in
                
                let frame = proxy.frame(in: .global)
                
                ZStack{
                    
                    Image("bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frame.width, height: frame.height)
                    
                    BlurView(effect: .systemChromeMaterialDark)
                    // Closing PopUP When Clicked @Back...
                        .onTapGesture {
                            withAnimation(Animation.easeInOut.speed(1)){
                                animationModel.showDetail = false
                            }
                        }
                }
            }
            .ignoresSafeArea()
            
            // Going to enlarge the Action Sheet when its Long Pressed Intially...
            
            VStack{
                
                HStack(spacing: 8){
                    
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.white)
                    
                    Text("Verizon")
                        .fontWeight(.semibold)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "alarm.fill")
                    
                    Text("53%")
                        .fontWeight(.semibold)
                    
                    Image(systemName: "battery.25")
                }
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top,50)
                
                
                HStack(spacing: 15){
                    
                    // For Getting Equal Width...
                    
                    ZStack{
                        
                        if !animationModel.showDetail{
                            GeometryReader{proxy in
                                
                                VStack(spacing: 15){
                                    
                                    // Action Buttons....
                                    
                                    HStack(spacing: 15){
                                        
                                        ActionButton(image: "airplane", title: "Airplane Mode", isSelected: $animationModel.airplaneMode, animation: animation)
                                        
                                        ActionButton(image: "antenna.radiowaves.left.and.right", title: "Mobile Data", isSelected: $animationModel.dataMode, animation: animation)
                                    }
                                    
                                    HStack(spacing: 15){
                                        
                                        ActionButton(image: "wifi", title: "Wifi", isSelected: $animationModel.WIFIMode, animation: animation)
                                        
                                        ActionButton(image: "airplayaudio", title: "Airdrop", isSelected: $animationModel.airDropMode, animation: animation)
                                    }
                                }
                                .padding(15)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                // TO Avoid Glitchy Effect..
                                // were going to put those expnaded buttons in bacground...
                                // so that it will look like expanding....
                                .background(
                                
                                    HStack(spacing: 15){
                                        
                                        ActionButton(image: "wave.3.right", title: "NFC", isSelected: $animationModel.NFCMode, animation: animation)
                                        
                                        ActionButton(image: "personalhotspot", title: "Personal Hotspot", isSelected: $animationModel.hotspotMode, animation: animation)
                                    }
                                    .offset(y: 40)
                                    .padding(.horizontal,10)
                                    .opacity(0)
                                )
                                .background(
                                    BlurView(effect: .dark)
                                        .cornerRadius(30)
                                        .matchedGeometryEffect(id: "ACTION_SHEET", in: animation)
                                )
                                
                                .scaleEffect(animationModel.enalrgeActions ? 0.9 : 1)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .onLongPressGesture(minimumDuration: 0.25) {
                        
                        withAnimation(.easeInOut){
                            animationModel.enalrgeActions = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            
                            // Gibing Little Vibrate When Opens...
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            
                            // Toggling The Detail View...
                            withAnimation(Animation.easeInOut.speed(1.3)){
                                
                                animationModel.enalrgeActions = false
                                
                                animationModel.showDetail = true
                            }
                        }
                    }
                    // Late Response when click on Action Button...
                    // so a work around...
                    // just set long press gesture for both action button..
                    
                    GeometryReader{proxy in
                        
                        VStack{
                            
                            Text("Not Playing")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            
                            HStack{
                                
                                Button(action: {}, label: {
                                    Image(systemName: "backward.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                })
                                .disabled(true)
                                .opacity(0.6)
                                
                                Spacer(minLength: 0)
                                
                                Button(action: {}, label: {
                                    Image(systemName: "play.fill")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                })
                                
                                Spacer(minLength: 0)
                                
                                Button(action: {}, label: {
                                    Image(systemName: "forward.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                })
                                .disabled(true)
                                .opacity(0.6)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .background(
                            BlurView(effect: .dark)
                                .cornerRadius(30)
                        )
                    }
                }
                // Max Height By Removing The spacing and Padding....
                // 75 = horizontal padding = 30 + spacing = 15
                .frame(height: (getRect().width - 75) / 2)
                .padding(.top,40)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal,30)
            // Hiding When Detail Page Opens...
            .opacity(animationModel.showDetail ? 0 : 1)
            
            GeometryReader{proxy in
                
                if animationModel.showDetail{
                    
                    VStack(spacing: 15){
                        
                        // Action Buttons....
                        
                        HStack(spacing: 15){
                            
                            ActionButton(image: "airplane", title: "Airplane Mode", isSelected: $animationModel.airplaneMode, animation: animation)
                            
                            ActionButton(image: "antenna.radiowaves.left.and.right", title: "Mobile Data", isSelected: $animationModel.dataMode, animation: animation)
                        }
                        
                        HStack(spacing: 15){
                            
                            ActionButton(image: "wifi", title: "Wifi", isSelected: $animationModel.WIFIMode, animation: animation)
                            
                            ActionButton(image: "airplayaudio", title: "Airdrop", isSelected: $animationModel.airDropMode, animation: animation)
                        }
                        
                        // Expanded View....
                        
                        HStack(spacing: 15){
                            
                            ActionButton(image: "wave.3.right", title: "NFC", isSelected: $animationModel.NFCMode, animation: animation)
                            
                            ActionButton(image: "personalhotspot", title: "Personal Hotspot", isSelected: $animationModel.hotspotMode, animation: animation)
                        }
                    }
                    .padding(.vertical)
                    .padding(.horizontal,25)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(
                        BlurView(effect: .dark)
                            .cornerRadius(30)
                            .matchedGeometryEffect(id: "ACTION_SHEET", in: animation)
                    )
                    
                }
            }
            .frame(height: getRect().height / 2.2)
            .padding(.horizontal,30)
        }
        .environmentObject(animationModel)
        .statusBar(hidden: true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct ActionButton: View {
    
    var image: String
    var title: String
    @Binding var isSelected: Bool
    // For Smooth Transition...
    
    var animation: Namespace.ID
    
    @EnvironmentObject var animationModel: AnimationViewModel
    
    var body: some View{
        
        VStack{
            
            let actualFrameSize = (getRect().width - 75) / 2
            
            // Changing Image Colors....
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(image == "wifi" && !isSelected ? .black : .white)
                // Calculating Frame By Removing Spacing and padding...
                // 45 = Padding = 15 + spacing: 15
                .frame(width: (actualFrameSize - 45) / 2, height: (actualFrameSize - 45) / 2)
                .background(
                
                    ZStack{
                        
                        if image == "wifi"{
                            isSelected ? Color.blue : Color.white
                        }
                        else if image == "airplane"{
                            isSelected ? Color.orange: Color.gray.opacity(0.25)
                        }
                        else if image == "antenna.radiowaves.left.and.right"{
                            isSelected ? Color.green : Color.gray.opacity(0.25)
                        }
                        else{
                            isSelected ? Color.blue : Color.gray.opacity(0.25)
                        }
                    }
                )
                .clipShape(Circle())
            
            if animationModel.showDetail{
                
                Text(title)
                    .font(.system(size: 14,weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.top,5)
                
                Text(isSelected ? "On" : "Off")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        // Setting Geometry ID For Smooth Transition...
        .matchedGeometryEffect(id: image, in: animation)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(
        
            TapGesture()
                .onEnded({ () in
                    
                    withAnimation(.linear){
                        isSelected.toggle()
                    }
                })
                .simultaneously(with: LongPressGesture(minimumDuration: 0.2).onEnded({ _ in
                    
                    withAnimation(.easeInOut){
                        animationModel.enalrgeActions = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                
                        // Toggling The Detail View...
                        withAnimation(Animation.easeInOut.speed(1.3)){
                            
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            
                            animationModel.enalrgeActions = false
                            
                            animationModel.showDetail = true
                        }
                    }
                    
                }))
        )
        .disabled(animationModel.enalrgeActions)
    }
}
