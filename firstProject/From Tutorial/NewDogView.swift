//
//  NewDogView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-18.
//

import SwiftUI

struct NewDogView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newDog = ""
    var body: some View {
        TextField("Dog", text: $newDog)
        
        Button {
            //add dog
            dataManager.addDog(dogBreed: newDog)
        } label: {
            Text("Save")
        }

    }
}

struct NewDogView_Previews: PreviewProvider {
    static var previews: some View {
        NewDogView()
    }
}
