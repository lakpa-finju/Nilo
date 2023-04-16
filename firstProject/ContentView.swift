//
//  ContentView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-16.
//

import SwiftUI

struct ContentView: View {
    @State var isTextShowing = true
    var body: some View {
            VStack {
                if isTextShowing {
                    Text("Hello, world! XCode12 Branch ")
                        .padding()
                        .font(.title)
                } else {
                    /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
                        .padding()
                }
                Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                    isTextShowing.toggle()
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
