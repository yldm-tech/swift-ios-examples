//
//  AddMeeting.swift
//  Meeting App UI (iOS)
//
//  Created by Balaji on 02/07/21.
//

import SwiftUI

struct AddMeeting: View {
    
    @EnvironmentObject var homeModel: HomeViewModel
    
    // Meeting Object to hold Data...
    @State var currentMeetingData = Meeting(title: "", timing: Date())
    
    // Show Picker..
    @State var showDatePicker = false
    
    @State var currentMeetingType = "Public"
    
    var body: some View {
        
        ScrollView(UIScreen.main.bounds.height < 850 ? .vertical : .init(), showsIndicators: false, content: {
            
            VStack(spacing: 20){
                
                HStack{
                    
                    Button {
                        
                        withAnimation{
                            homeModel.addNewMeeting.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()

                    Image("Profile")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                .overlay(
                
                    Text("New Meeting")
                        .font(.system(size: 18))
                )
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Enter Meeting Name")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    TextField("iJustine", text: $currentMeetingData.title)
                    // Making it bold...
                        .font(.system(size: 16).bold())
                    
                    Divider()
                }
                .padding(.top,10)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Timing")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    HStack{
                        
                        // Expading Date Component...
                        let time = currentMeetingData.timing.formatted(date: .omitted, time: .shortened)
                        
                        let date = currentMeetingData.timing.formatted(date: .abbreviated, time: .omitted)
                        
                        Text("\(time), \(date)")
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 10)
                        
                        // Custom Date Picker...
                        Button {
                            
                            withAnimation{
                                showDatePicker.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                                .padding(6)
                                .background(.yellow,in: Circle())
                        }

                    }
                    
                    Divider()
                }
                .padding(.top,10)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Select Colloborators")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    

                    HStack(spacing: -10){
                        
                        ForEach(1...3,id: \.self){index in
                            
                            Image("animoji\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(4)
                                .background(.white,in: Circle())
                            // border...
                                .background(
                                
                                    Circle()
                                        .stroke(.black,lineWidth: 1)
                                )
                        }
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            
                        } label: {
                            Text("Contacts")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(
                                
                                    Capsule()
                                        .stroke(.black,lineWidth: 1)
                                )
                        }

                    }
                    
                    Divider()
                }
                .padding(.top,10)
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    Text("Meeting Type")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    // Simply Creating Array....
                    HStack(spacing: 15){
                        
                        ForEach(["Private","Public","On Invite"],id: \.self){tab in

                            MeetingTabButton(title: tab, currentType: $currentMeetingType)
                        }
                    }
                    
                    Divider()
                }
                .padding(.top,10)
                
                // Color...
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Meeting Card Color")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    let colors = [Color("Blue"),Color("Green"),Color("Purple"),Color("Red"),Color("Orange")]
                    
                    HStack(spacing: 12){
                        
                        ForEach(colors,id: \.self){color in
                            
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .opacity(
                                        
                                            currentMeetingData.cardColor == color ? 1 : 0
                                        )
                                )
                                .onTapGesture {
                                    currentMeetingData.cardColor = color
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 10)
                
                // Schedule Button...
                Button {
                    addMeeting()
                } label: {
                    Text("Schedule")
                        .foregroundColor(.white)
                        .padding(.vertical,6)
                        .padding(.horizontal,30)
                }
                .controlSize(.small)
                .buttonStyle(.borderedProminent)
                .tint(.black)
                .padding(.bottom,10)
                // disbaling button...
                .disabled(currentMeetingData.title == "")

            }
            .padding()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("Bg"))
        .overlay(CustomDatePicker(date: $currentMeetingData.timing, showPicker: $showDatePicker))
        .transition(.move(edge: .bottom))
    }
    
    func addMeeting(){
        
        withAnimation{
            homeModel.meetings.append(currentMeetingData)
            homeModel.addNewMeeting.toggle()
        }
    }
}

// Meeting tab Button...
struct MeetingTabButton: View{
    var title: String
    @Binding var currentType: String
    
    var body: some View{
        
        Button {
            
            withAnimation{
                currentType = title
            }
            
        } label: {
            Text(title)
                .font(.footnote)
                .foregroundColor(title != currentType ? .black : .white)
                .padding(.vertical,8)
                // Max Width...
                .frame(maxWidth: .infinity)
                .background(
                
                    Capsule()
                        .stroke(.black,lineWidth: 1)
                )
                .background(
                
                    Capsule()
                        .fill(.black.opacity(title == currentType ? 1 : 0))
                )
        }

    }
}

// Custom Date Picker...
struct CustomDatePicker: View{
    
    @Binding var date: Date
    @Binding var showPicker: Bool
    
    var body: some View{
        
        ZStack{
            
            // Blur Effect...
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            DatePicker("", selection: $date, displayedComponents: [.date,.hourAndMinute])
                .labelsHidden()
            
            // Close Button...
            Button {
                
                withAnimation{
                    showPicker.toggle()
                }
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(.gray,in: Circle())
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)

        }
        .opacity(showPicker ? 1 : 0)
    }
}

struct AddMeeting_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
