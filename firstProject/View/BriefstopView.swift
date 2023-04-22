//
//  BriefstopView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct BriefstopView: View {
    @EnvironmentObject var eventManager: EventManager
    @State private var showPopup = false
    
    var body: some View {
        VStack{
            Text("Brief Stop").font(.system(.title))
            List(eventManager.events, id:\.id){event in
                if event.location == "Brief Stop" {
                
                    HStack{
                        Text(event.name)
                        Text("is eating at " + event.time)
                        
                    }.font(.system(.body))
                        .foregroundColor(.black)
                }
            }
        }
        .offset(y:-40)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink{
                    NewSwipeView()
                }label: {
                    Text("Offer Swipe(s)")
                    Image(systemName: "plus")
                }

            })
        }
      
    }
}

struct BriefstopView_Previews: PreviewProvider {
    static var previews: some View {
        BriefstopView().environmentObject(EventManager())
    }
}
