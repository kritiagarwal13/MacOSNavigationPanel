//
//  ContentView.swift
//  NavigationPanel
//
//  Created by Kriti Agarwal on 03/01/22.
//

import SwiftUI

struct Options: Hashable {
    let title: String
    let imgName: String
}

struct ContentView: View {
    @State var currentOption = 0
    
    let options: [Options] = [
        .init(title: "Home", imgName: "house"),
        .init(title: "About", imgName: "info.circle"),
        .init(title: "Settings", imgName: "gear"),
        .init(title: "Social", imgName: "message")
    ]
    
    var body: some View {
        NavigationView{
            ListView(
                options: options,
                currentSelection: $currentOption
            )
            switch currentOption {
            case 0:
                Text("About Kriti Agarwal View")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct MainView: View {
    let cols: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    let videoImages = Array(1...6).map { "img\($0)" }
    
    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            LazyVGrid(columns: cols) {
                ForEach(videoImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            Spacer()
        }
    }
}

struct ListView: View {
    let options: [Options]
    @Binding var currentSelection: Int
    var body: some View {
        VStack {
            let current = options[currentSelection]
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imgName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text(option.title)
                        .foregroundColor(current == option ? Color(.linkColor) : Color(.labelColor))
                    Spacer()
                }
                .padding(8)
                .onTapGesture {
                    if currentSelection == 1 {
                        currentSelection = 0
                    } else {
                        currentSelection = 1
                    }
                }
            }
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
