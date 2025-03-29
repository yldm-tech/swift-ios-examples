//
//  Home.swift
//  Home
//
//  Created by Balaji on 15/09/21.
//

import SwiftUI

struct Home: View {
    
    // Sample Furnitures....
    @State var furnitures: [Furniture] = [

        Furniture(name: "Side Table", description: "Amazing stylish and widely selled table !!!", price: "$200",image: "sideTable"),
        Furniture(name: "Desktop Table", description: "Best IKEA Table at affordable price.", price: "$120",image: "desktopTable"),
        Furniture(name: "Table Clock", description: "Best selling Table Clock in whole market", price: "$200",image: "clock"),
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 18){
                
                HStack{
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "sidebar.left")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                    }

                }
                .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Furniture in\nUnique Style")
                        .font(.largeTitle.bold())
                    
                    Text("We have wide range of furniture")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.vertical,20)
                
                // on iOS 15 you can directly pass binding from foreach...
                ForEach($furnitures){$furniture in
                    
                    CardView(furniture: $furniture)
                }
            }
            .padding()
            // dont forget to add bottom padding...
            .padding(.bottom,100)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View{
    
    @Binding var furniture: Furniture
    // Offset for gesture...
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    
    // Last stored Offset...
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View{
        
        HStack{
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(furniture.name)
                    .fontWeight(.bold)
                
                Text(furniture.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(furniture.price)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            Image(furniture.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
        }
        .padding(.horizontal)
        .padding(.vertical,6)
        .background(
        
            ZStack{
                
                Color.white
                
                Color("Card")
                    .opacity(-offset / 100)
            }
        )
        .cornerRadius(15)
        .contentShape(Rectangle())
        .offset(x: offset)
        .background(
        
            ZStack(alignment: .trailing){
                
                Color("Brown")
                
                VStack(spacing: 35){
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title2)
                    }
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                    }
                }
                .foregroundColor(.white)
                .padding(.trailing,35)
            }
            .cornerRadius(15)
            .padding(.horizontal,2)
        )
        .gesture(
        
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    
                    out = value.translation.width
                }).onEnded({ value in
                    
                    // checking..
                    let translation = value.translation.width
                    
                    if translation < 0 && -translation > 100{
                        offset = -100
                    }
                    else{
                        offset = 0
                    }
                    
                    lastStoredOffset = offset
                })
        )
        .animation(.easeInOut, value: gestureOffset == 0)
        // updating offset...
        .onChange(of: gestureOffset) { newValue in
            offset = (gestureOffset + lastStoredOffset) > 0 ? 0 : (gestureOffset + lastStoredOffset)
        }
    }
}
