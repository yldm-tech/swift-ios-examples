//
//  Home.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var detailView: Bool = false
    @State private var selectedRoom: Room?
    @State private var dragOffset: CGFloat = 0
    /// Delay Actions
    @State private var bookOpenTask: DispatchWorkItem?
    @State private var closeOpenTask: DispatchWorkItem?
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                HeaderView()
                
                ForEach(sampleRooms) { room in
                    GeometryReader {
                        let size = $0.size
                        
                        Image(room.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .overlay(alignment: .bottomLeading) {
                                GeometryReader(content: { _ in
                                    Color.clear
                                        .anchorPreference(key: MAnchorKey.self, value: .bounds) { anchor in
                                            return [room.id.uuidString: anchor]
                                        }
                                })
                                .frame(height: 210)
                                .frame(height: 235)
                                .offset(x: 15)
                                .clipped()
                            }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        expandBook(room)
                    }
                }
                .frame(height: 250)
            }
            .padding(15)
        }
        /// Using Overlay Preference To create a Custom Hero Effect (AKA Matched Geometry Effect)
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                ForEach(sampleRooms) { room in
                    if let anchor = value[room.id.uuidString], selectedRoom?.id != room.id {
                        let rect = geometry[anchor]
                        BookView(
                            selectedRoom: $selectedRoom,
                            dragOffset: $dragOffset,
                            host: room.host
                        )
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                        .allowsHitTesting(false)
                        .transition(.identity)
                    }
                }
            })
        })
        .overlay(alignment: .top) {
            if selectedRoom != nil {
                Rectangle()
                    .fill(.black.opacity(0.35))
                    .opacity(detailView ? 1 : 0)
                    .ignoresSafeArea()
                    .onTapGesture(perform: hideView)
            }
        }
        .overlay(alignment: .bottom, content: {
            DetailView(
                selectedRoom: $selectedRoom,
                dragOffset: $dragOffset,
                detailView: $detailView,
                hideView: {
                    hideView()
                }
            )
        })
        .overlayPreferenceValue(MAnchorKey.self, { value in
            GeometryReader(content: { geometry in
                if let selectedRoom, let anchor = value[selectedRoom.id.uuidString] {
                    let rect = geometry[anchor]
                    BookView(
                        selectedRoom: $selectedRoom,
                        dragOffset: $dragOffset,
                        host: selectedRoom.host
                    )
                    .frame(width: rect.width, height: rect.height)
                    .offset(x: rect.minX, y: rect.minY)
                    .allowsHitTesting(false)
                    .transition(.identity)
                }
            })
        })
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Where to?")
                    .font(.callout)
                    .fontWeight(.bold)
                
                Text("Anywhere . Any Week . Add Guests")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 0)
            
            Image(systemName: "line.3.horizontal")
                .font(.title3)
                .padding(12)
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(color: .black.opacity(0.1), radius: 5)
                }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            Capsule()
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.1), radius: 8, x: -5, y: -5)
        }
        .padding(.bottom, 15)
    }
    
    /// Closing Book With Animation
    func hideView() {
        withAnimation(.snappy) {
            selectedRoom?.showContent = false
            dragOffset = .zero
        }
        
        /// If there is any previous delay task is present, cancelling that task and initiating new task
        if let closeOpenTask {
            closeOpenTask.cancel()
            self.closeOpenTask = nil
        }
        
        closeOpenTask = .init(block: {
            withAnimation(.bouncy, completionCriteria: .removed) {
                selectedRoom?.toggle = false
                selectedRoom?.rotation = 0
                detailView = false
            } completion: {
                /// Since It will be fired later, sometimes the result will be vice versa, so check if the view is closed; if so, remove the selected room data; otherwise, do nothing
                if !(selectedRoom?.toggle ?? true) {
                    selectedRoom = nil
                }
            }
        })
        
        if let closeOpenTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: closeOpenTask)
        }
    }
    
    /// Opening Book With Animation
    func expandBook(_ room: Room) {
        selectedRoom = room
        
        withAnimation(.snappy) {
            detailView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            withAnimation(.snappy) {
                selectedRoom?.showContent = true
            }
        }
        
        /// If there is any previous delay task is present, cancelling that task and initiating new task
        if let bookOpenTask {
            bookOpenTask.cancel()
            self.bookOpenTask = nil
        }
        
        bookOpenTask = .init(block: {
            withAnimation(.bouncy) {
                selectedRoom?.toggle = true
                selectedRoom?.rotation = 180
            }
        })
        
        if let bookOpenTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: bookOpenTask)
        }
    }
}

#Preview {
    ContentView()
}
