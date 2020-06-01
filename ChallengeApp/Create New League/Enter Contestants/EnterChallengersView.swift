//
//  CreateNewLeagueEnterChallengersView.swift
//  ChallengeApp
//
//  Created by Michael Sevy on 5/14/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct EnterChallengersView: View {
    var leagueName: String
    var managers: [String]
    var user: User?
    
    @State var managerCounter = 0
    @State var challengers = [String]()
    @State var challengerCount = 0
    @State var buttonTapped: Int? = nil
    @State var challenger1 = ""
    @State var challenger2 = ""
    @State var challenger3 = ""
    @State var challenger4 = ""
    @State var challenger5 = ""
    @State var challenger6 = ""
    @State var challenger7 = ""
    @State var challenger8 = ""
    @State var challenger9 = ""
    @State var buttonTitle = "Next Manager"
    @ObservedObject var viewModel = EnterChallengersViewModel()
    let pub = NotificationCenter.default.publisher(for: Notification.Name.LeagueCompletedSaving)

    
    var body: some View {
        VStack {
            List {
                if (Challenger.challengerCount / managers.count) == 2 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter]):")
                        .bold()
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 3 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 4 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 5 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                        Text("5. \(challenger5)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 6 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                        Text("5. \(challenger5)")
                        Text("6. \(challenger6)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 7 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                        Text("5. \(challenger5)")
                        Text("6. \(challenger6)")
                        Text("7. \(challenger7)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 8 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                        Text("5. \(challenger5)")
                        Text("6. \(challenger6)")
                        Text("7. \(challenger7)")
                        Text("8. \(challenger8)")
                    }
                } else if (Challenger.challengerCount / managers.count) == 9 {
                    if challenger1 == "" {
                        Text("Choose a Challenger for \(managers[managerCounter])")
                    } else {
                        Text("1. \(challenger1)")
                        Text("2. \(challenger2)")
                        Text("3. \(challenger3)")
                        Text("4. \(challenger4)")
                        Text("5. \(challenger5)")
                        Text("6. \(challenger6)")
                        Text("7. \(challenger7)")
                        Text("8. \(challenger8)")
                        Text("9. \(challenger9)")
                    }
                }
                Spacer()
                ForEach(Challenger.challengers, id: \.self) { challenger in
                    Button(action: {
                        self.assign(challenger: challenger)
                    }) {
                        Text(challenger)
                    }
                }
            }
            NavigationLink(destination: ManagerTabView(user: user!), tag: 1, selection: $buttonTapped) { //ManagerTabView(user: user), tag: 1, selection: $buttonTapped) {
            // Move on to next manger or finish up
                Button(action: {
                    self.save(manager: self.managers[self.managerCounter])
                }) {
                    Text(self.buttonTitle)
                }
            }
            .padding(20)
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .babyBlue]), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.black)
            .cornerRadius(40)
            Spacer()
        }
        .navigationBarTitle(managers[managerCounter])
    }
    
    func save(manager: String) {
        viewModel.updateLeagueWith(contestantNames: challengers, managerEmail: manager, leagueName: leagueName)
        
        if managerCounter == managers.count - 1 {
            print("end of entry")
            DefaultsManager.saveDefaultLeague(name: leagueName)
            self.buttonTapped = 1
        } else if managerCounter == managers.count - 2 {
            self.buttonTitle = "Complete League"
            self.buttonTapped = 0
            self.clearChallengersForNextManagerEntry()
        } else {
            self.buttonTapped = 0
            self.clearChallengersForNextManagerEntry()
        }
    }
    
    func clearChallengersForNextManagerEntry() {
        challengers.removeAll()
        challengerCount = 0
        managerCounter += 1

        challenger1 = ""
        challenger2 = ""
        challenger3 = ""
        challenger4 = ""
        challenger5 = ""
        challenger6 = ""
        challenger7 = ""
        challenger8 = ""
        challenger9 = ""
    }
    
    func assign(challenger: String) {
        if challengerCount == 0 {
            challenger1 = challenger
            challengerCount = 1
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)
        } else if challengerCount == 1 {
            challenger2 = challenger
            challengerCount = 2
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 2 {
            challenger3 = challenger
            challengerCount = 3
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 3 {
            challenger4 = challenger
            challengerCount = 4
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 4 {
            challenger5 = challenger
            challengerCount = 5
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 5 {
            challenger6 = challenger
            challengerCount = 6
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 6 {
            challenger7 = challenger
            challengerCount = 7
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 7 {
            challenger8 = challenger
            challengerCount = 8
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 8 {
            challenger9 = challenger
            challengerCount = 9
            let arr = Challenger.challengers.filter { $0 != challenger }
            Challenger.challengers = arr
            challengers.append(challenger)

        } else if challengerCount == 9 {
            challenger9 = challenger
        }
    }
}

struct EnterChallengersView_Previews: PreviewProvider {
    static var previews: some View {
        EnterChallengersView(leagueName: "Test League Name", managers: ["Sevy@gmial.com", "Shamir@gmail.ocm", "BJ@gmail.com"])
    }
}