//
//  DetailView.swift
//  Book3DAnimation
//
//  Created by Balaji on 19/07/23.
//

import SwiftUI

struct DetailView: View {
    @Binding var selectedRoom: Room?
    @Binding var dragOffset: CGFloat
    @Binding var detailView: Bool
    var hideView: () -> ()
    var body: some View {
        if let room = selectedRoom, detailView {
            GeometryReader {
                let size = $0.size
                
                VStack(spacing: 0) {
                    GeometryReader { _ in
                        Color.clear
                            .anchorPreference(key: MAnchorKey.self, value: .bounds, transform: { anchor in
                                return [room.id.uuidString: anchor]
                            })
                    }
                    .frame(height: 210)
                }
                .padding(20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                        .offset(y: (selectedRoom?.showContent ?? false) ? 0 : size.height + 50)
                        .offset(y: dragOffset)
                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            dragOffset = max(value.translation.height, 0)
                        }).onEnded({ value in
                            if value.translation.height > (size.height * 0.25) {
                                hideView()
                            } else {
                                withAnimation(.snappy) {
                                    dragOffset = .zero
                                }
                            }
                        })
                )
            }
            .frame(height: 600)
            .transition(.offset(y: 0))
        }
    }
}

#Preview {
    ContentView()
}
