//
//  LocationView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-20.
//

import SwiftUI

struct LocationView: View {
    @StateObject var eventManager = EventsManager()
    @StateObject var reservationsManager = ReservationsManager()
    @StateObject var userProfileManager = UserProfilesManager()
    @StateObject var profileImagesManager = ProfileImagesManager()
    @State private var profileImage: UIImage?
    @State private var doesExist = false
    
    //this function awaits until we get response from the database
    private func updateDoesExist() async {
            doesExist = await reservationsManager.checkExistence(collectionsName: "Events", documentId: eventManager.geteUserId())
        }

    
    var locations = ["Marketplace", "Cafe 77", "Fireside", "Foodside", "Hillel", "Brief Stop"]
    
    var body: some View {
        NavigationStack {
            ZStack{
                //this is for background
                Color.white
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 800)
                    .rotationEffect(.degrees(135))
                    .offset(x:70,y:-400)
                
                VStack(alignment: .center, spacing: 10){
                    //for Marketplace
                    NavigationLink{
                        MarketplaceView()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                            
                    }label: {
                        Text("Marketplace")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //for Cafe 77
                    NavigationLink{
                        Cafe77View()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Cafe 77")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                    }
                    
                    //for Hillel
                    NavigationLink{
                        HillelView()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Hillel")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //for Fireside
                    NavigationLink{
                        FiresideView()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Fireside")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //For Foodside
                    NavigationLink{
                        FoodsideView()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Foodside")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    //For Brief Stop
                    NavigationLink{
                        BriefstopView()
                            .environmentObject(eventManager)
                            .environmentObject(reservationsManager)
                    }label: {
                        Text("Brief Stop")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                   
                    //Foot note
                    HStack {
                        Spacer()
                        Text("© 2023 - Created by Lakpa F. Sherpa")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .offset(y:190)
                        Spacer()
                    }
                    
                }
                .offset(y:-70)
                .navigationTitle("Locations")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        if (doesExist == false){
                            NavigationLink{
                                NewSwipeView()
                                    .environmentObject(eventManager)
                            }label: {
                                Text("Offer Swipe(s)")
                                Image(systemName: "plus")
                            }
                        }else{
                            NavigationLink{
                                CancelEventView()
                                    .environmentObject(eventManager)
                            }label: {
                                Text("Cancel my Offer")
                            }
                        }
                        
                        
                    })
                    
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        NavigationLink{
                            UserProfileView()
                                .environmentObject(eventManager)
                                .environmentObject(userProfileManager)
                                .environmentObject(profileImagesManager)
                                .environmentObject(reservationsManager)
                        }label: {
                            //Text("Your profile")
                            //Image(systemName: "plus")
                            if let profileImage = profileImage{
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40,height: 40)
                                    .clipShape(Circle())
                    
                            }else{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 7)
                                    .padding(.bottom, 20)
                                    .offset(y:15)
                                    .ignoresSafeArea()
                            }

                        }
                        
                        
                    })
                }
                
            }
            
            
        }
        .onReceive(profileImagesManager.$profileImage, perform: { image in
            profileImage = image
        })
        .accentColor(Color(.label))
        .task {
                    await updateDoesExist()
                }
    }
    
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
        
            
    }
}
