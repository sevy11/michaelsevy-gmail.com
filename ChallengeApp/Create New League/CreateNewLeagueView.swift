//
//  CreateNewLeagueView.swift
//  ChallengeApp
//
//  Created by Michael Sevy on 5/8/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import SwiftUI
import Firebase

struct CreateNewLeagueView: View {
    var user: User?
    
    @State private var name = ""
    @State var leagueType = "Choose League:"
    @State var managersInLeague = 0
    @State var buttonTapped: Int? = nil
    @State var selected = false
    @State var showNameAlert = false
    

    var body: some View {
            Section {
                VStack {
                    List {
                        Text(selected ? "\(leagueType.uppercased())" : leagueType)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        if selected == false {
                            Button(action: {
                                self.leagueType = "The Challenge"
                                self.selected = true
                            }) {
                                Text("The Challenge")
                            }
                            Button(action: {
                                self.leagueType = "The Challenge"
//                                self.leagueType = "Survivor"
                                self.selected = true
                            }) {
                                Text("Survivor(Coming soon)")
                            }
                        } else {
                            EmptyView()
                        }
                        Text("League Name:")
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        TextField("Type your league name...", text: $name)
                            // @TODO add check for name.isvalid
//                        if !isValidEmail(email: name) {
//                            self.showNameAlert = true
//                        }
                            .padding(EdgeInsets(top: 8, leading: 16,
                                                bottom: 8, trailing: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.black)
                        )
                            .shadow(color: Color.gray.opacity(0.4),
                                    radius: 3, x: 1, y: 2)
//                            .alert(isPresented: $showNameAlert) { () -> Alert in
//                                Alert(title: Text("name not valid")).padding()
//                        }
                        Text("Enter Managers in league (3-8):")
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                      Picker(selection: $managersInLeague, label: Text("")) {
                            ForEach(0 ..< Manager.managersAvailable.count) { index in
                                Text(Manager.managersAvailable[index]).tag(index)
                            }
                        }.id(managersInLeague)
                            .pickerStyle(WheelPickerStyle())
                            .padding(EdgeInsets(top: -20, leading: 0, bottom: -20, trailing: 0))
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Manager Count: \(Manager.managersAvailable[managersInLeague])")
                            Spacer()
                        }
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Leagues will begin scoring with week 2")
                            Spacer()
                        }
                    }
                    NavigationLink(destination: CreateNewLeagueDetailManagerView(leagueName: self.name, managerCount: self.managersInLeague + 3, user: user!), tag: 1, selection: $buttonTapped) {
                        Button(action: {
                            self.buttonTapped = 1
                        }) {
                            Text("Enter Manager Names")
                                .bold()
                        }
                    }.alert(isPresented: $showNameAlert) {
                        Alert(title: Text("Alert"), message: Text("Team name cannot have unique characters"))
                    }
                    .padding(20)
                    .background(buttonColor)
                    .foregroundColor(buttonTitleColor)
                    .cornerRadius(40)
                    .disabled(!allowedToEnterTeams)
                    .disableAutocorrection(true)
                    Spacer()
                }
            }
        .navigationBarTitle("Create New League")
    }
    
     var dateClosedRange: ClosedRange<Int> {
        let min = 3
        let max = 8
//        let min = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
//        let max = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        return min...max
    }

    func isValidEmail(email: String) -> Bool {
        return email.contains("[") || email.contains("]") || email.contains("$") || email.contains("#") || email.contains(".")
    }
    
    var leagueTypeEntered: String {
        return leagueType == "Choose League:" ? leagueType : "Choose League:"
    }
    
    var leagueShow: Bool {
        return leagueType == "Choose League:" ? true : false
    }
    
    var allowedToEnterTeams: Bool {
        return !name.isEmpty && selected
    }
    
    var buttonColor: LinearGradient {
           return allowedToEnterTeams ? LinearGradient(gradient: Gradient(colors: [.gray, .babyBlue]), startPoint: .leading, endPoint: .trailing) : LinearGradient(gradient: Gradient(colors: [.red, .babyBlue]), startPoint: .leading, endPoint: .trailing)
    }
    
    var buttonTitleColor: Color {
        return allowedToEnterTeams ? .black : .white
    }
}

struct CreateNewLeagueView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewLeagueView()
    }
}
