//
//  BookView.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

struct BookView: View {
    @Binding var selectedRoom: Room?
    @Binding var dragOffset: CGFloat
    var host: Room.Host
    var body: some View {
        let toggle = selectedRoom?.host.id == host.id ? (selectedRoom?.toggle ?? false) : false
        let rotation = selectedRoom?.host.id == host.id ? (selectedRoom?.rotation ?? 0) : 0
        let showContent = selectedRoom?.host.id == host.id ? (selectedRoom?.showContent ?? false) : false
        let offset = selectedRoom?.host.id == host.id ? dragOffset : 0
        
        GeometryReader {
            let size = $0.size
            let width = size.width / 2
            
            ZStack(alignment: .leading) {
                /// Book Right Side
                Rectangle()
                    .fill(.white)
                    .frame(width: width + (toggle ? 0 : 35), alignment: .leading)
                    .overlay(content: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(host.reviews)
                                .font(.title3.bold())
                            
                            Text("Reviews")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .fill(.gray.opacity(0.2))
                                .frame(height: 1)
                                .padding(.vertical, 2)
                            
                            HStack(spacing: 8) {
                                Text(host.rating)
                                    .font(.title3.bold())
                                
                                Image(systemName: "star.fill")
                                    .font(.callout)
                                    .offset(y: -2)
                            }
                            
                            Text("Rating")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .fill(.gray.opacity(0.2))
                                .frame(height: 1)
                                .padding(.vertical, 2)
                            
                            Text("5")
                                .font(.title3.bold())
                            
                            Text("Years Hosting")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(20)
                    })
                    .clipShape(.rect(bottomTrailingRadius: 20, topTrailingRadius: 20))
                    .clipShape(.rect(topLeadingRadius: toggle ? 20 : 0, bottomLeadingRadius: toggle ? 20 : 0))
                    .background(content: {
                        Rectangle()
                            .fill(.white)
                            .clipShape(.rect(bottomTrailingRadius: 20, topTrailingRadius: 20))
                            .clipShape(.rect(topLeadingRadius: !toggle ? 20 : 0, bottomLeadingRadius: !toggle ? 20 : 0))
                            .shadow(color: .black.opacity(rotation > 90 ? 0.1 : 0), radius: 5, x: 8)
                    })
                
                /// Book Left Side
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .frame(width: width)
                    .overlay(alignment: .leading, content: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.linearGradient(colors: [
                                .white,
                                .clear,
                                .white,
                            ], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 15)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 5, y: 0)
                            .opacity(rotation > 90 ? 0 : 1)
                    })
                    .overlay(content: {
                        /// Book Flip Using the New Keyframe API
                        KeyframeAnimator(initialValue: CGFloat.zero, trigger: rotation) { value in
                            ZStack {
                                if value > 90 {
                                    Rectangle()
                                        .fill(.white)
                                        .overlay {
                                            VStack(spacing: 8) {
                                                ImageView(host, size.width * 0.3)
                                                
                                                Text(host.name)
                                                    .font(.title2.bold())
                                                    .padding(.top, 5)
                                                
                                                Label("Superhost", systemImage: "person.fill")
                                            }
                                            .padding(15)
                                        }
                                        .rotation3DEffect(.init(degrees: -180), axis: (x: 0, y: 1, z: 0))
                                } else {
                                    ImageView(host, width * 0.7)
                                        .offset(x: 7.5)
                                }
                            }
                        } keyframes: { _ in
                            KeyframeTrack {
                                SpringKeyframe(rotation)
                            }
                        }
                    })
                    .clipShape(.rect(bottomTrailingRadius: 20, topTrailingRadius: 20))
                    .clipShape(.rect(topLeadingRadius: toggle ? 0 : 10, bottomLeadingRadius: toggle ? 0 : 10))
                    .background(content: {
                        Rectangle()
                            .fill(.white)
                            .clipShape(.rect(bottomTrailingRadius: 20, topTrailingRadius: 20))
                            .clipShape(.rect(topLeadingRadius: !toggle ? 10 : 0, bottomLeadingRadius: !toggle ? 10 : 0))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 8)
                            .shadow(color: .black.opacity(rotation > 90 ? 0 : 0.05), radius: 5, x: -5)
                            .padding(.leading, rotation > 90 ? -16 : 0)
                    })
                    .modifier(BookRotationHelper(rotation: rotation))
                    .modifier(BookRotationHelper(rotation: toggle ? 0 : 10))
            }
            .offset(x: toggle ? width : 0)
            .offset(y: offset)
        }
        .scaleEffect(showContent ? 1 : 0.3, anchor: .bottomLeading)
    }
}

extension View {
    @ViewBuilder
    func ImageView(_ host: Room.Host, _ size: CGFloat = 100) -> some View {
        Image(host.profileImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
    }
}

#Preview {
    ContentView()
}
