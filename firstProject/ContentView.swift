//
//  ContentView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-16.
//

import SwiftUI

struct ContentView: View {
    /*@State var selectedOption = 0
    let options = ["Hillel", "Market Place","Third Year", "Cafe 77", "Tea House", "Breaf stop"]
    */
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .font(.title)
                    Text("Flex Give Away")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    /*Text("Select an Option: ")
                    Picker(selection: $selectedOption, label: Text(options[selectedOption])){
                        ForEach(0..<options.count){ index in
                            Text(self.options[index]).tag(index)
                            
                        }
                    }.pickerStyle(MenuPickerStyle())*/
                }
                
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
