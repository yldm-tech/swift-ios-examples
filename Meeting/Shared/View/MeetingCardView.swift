//
//  MeetingCardView.swift
//  Meeting App UI (iOS)
//
//  Created by Balaji on 02/07/21.
//

import SwiftUI

struct MeetingCardView: View {
    @Binding var meeting: Meeting
    var body: some View {
        
        VStack(spacing: 20){
            
            HStack(alignment: .top){
                
                VStack(alignment: .leading,spacing: 12){
                    
                    Text(meeting.timing.formatted(date: .numeric, time: .omitted))
                        .font(.caption)
                    
                    Text(meeting.title)
                        .font(.title2.bold())
                    
                    Text("\(meeting.members.count) Members Joining")
                        .font(.caption)
                }
                
                Spacer(minLength: 0)
                
                // Custom Toggle....
                ZStack(alignment: meeting.turnedOn ? .trailing : .leading){
                    
                    Capsule()
                        .fill(.secondary)
                        .foregroundStyle(.white)
                        .frame(width: 35, height: 18)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 18, height: 18)
                }
                .shadow(radius: 1.5)
                .onTapGesture {
                    
                    // changing on tap....
                    withAnimation{
                        meeting.turnedOn.toggle()
                    }
                }
            }
            .foregroundColor(getColor())
            
            HStack(spacing: -12){
                
                ForEach(1...3,id: \.self){index in
                    
                    Image("animoji\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .padding(4)
                        .background(.white,in: Circle())
                    // border...
                        .background(
                        
                            Circle()
                                .stroke(.black,lineWidth: 1)
                        )
                }
                
                Spacer(minLength: 15)
                
                Button {
                    
                } label: {
                    Text("Join")
                        .foregroundColor(.black)
                        .padding(.horizontal,10)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
                .tint(.white)
                .shadow(radius: 1.2)

            }
            .padding(.top,20)
        }
        .padding()
        .background(meeting.cardColor,in: RoundedRectangle(cornerRadius: 10))
    }
    
    // for color red and purple making card color as white....
    func getColor()->Color{
        
        if meeting.cardColor == Color("Purple") || meeting.cardColor == Color("Red"){
            return .white
        }
        
        return .black
    }
}

struct MeetingCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
