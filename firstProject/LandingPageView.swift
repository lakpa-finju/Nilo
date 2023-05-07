//
//  LandingPageView.swift
//  firstProject
//
//  Created by lakpafinju sherpa on 2023-04-27.
//

import SwiftUI

struct LandingPageView: View {
    @StateObject var eventsManager = EventsManager()
    @StateObject var reservationsManager = ReservationsManager()
    @StateObject var userProfileManager = UserProfilesManager()
    @StateObject var profileImagesManager = ProfileImagesManager()
    @StateObject var noticesManager = NoticesManager()
    @StateObject var travePlansManager = TravelPlansManager()
    @State private var profileImage: UIImage?
    var body: some View {
        NavigationStack{
            ZStack{
                //for Background effect
                Color.white
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 1000)
                    .rotationEffect(.degrees(40))
                    .offset(x:50,y:350)
                VStack(alignment: .center, spacing: 10){
                    NavigationLink{
                        LocationView()
                            .environmentObject(eventsManager)
                            .environmentObject(reservationsManager)
                            .environmentObject(userProfileManager)
                            .environmentObject(profileImagesManager)
                    }label: {
                        Text("Dining swipe(s)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primary)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink{
                        TravelPlansView()
                            .environmentObject(userProfileManager)
                            .environmentObject(travePlansManager)
                        
                    }label: {
                        Text("Find Travel Buddies")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primary)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink{
                        NoticesView()
                            .environmentObject(noticesManager)
                            .environmentObject(userProfileManager)
                        
                    }label: {
                        Text("Campus Events")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.primary)
                            .cornerRadius(10)
                    }
                    //Foot note
                    HStack {
                        Spacer()
                        Text("© 2023 - created by Lakpa & Zhengyi")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .offset(y:190)
                        Spacer()
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    NavigationLink{
                        UserProfileView()
                            .environmentObject(eventsManager)
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
            .onAppear{
                profileImage = profileImagesManager.loadProfileImage(profileImageId: eventsManager.geteUserId())
            }
            .accentColor(Color(.label))
            .navigationTitle("Home")
            
        }
                
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
            .environmentObject(EventsManager())
            .environmentObject(ReservationsManager())
            .environmentObject(UserProfilesManager())
            .environmentObject(ProfileImagesManager())
            .environmentObject(TravelPlansManager())
    }
}

