//
//  ChallengeTabViews.swift
//  ChallengeApp
//
//  Created by Michael Sevy on 4/7/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import FirebaseUI

struct ManagerTabView: View {
    var user: User?
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel = ManagerTabViewModel()

    
    private let pub = NotificationCenter.default.publisher(for: NSNotification.Name.UpdatedChallengerScores)
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ActivityIndicator(isAnimating: .constant(viewModel.isLoading), style: .large)
            } else if viewModel.leagues.count == 0 {
                Spacer()
                Text("There are no leagues associated with this email address.")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer()
                signOutButton
                Spacer()
            } else {
                Spacer()
                Text("Totals thru week \(viewModel.currentAvailableWeek)")
                    .foregroundColor(.orange)
                    .font(Font.system(size: 18))
                
                List(viewModel.managers, id: \.firebaseEmail) { manager in
                    ScrollView {
                        VStack {
                            Spacer()
                            Text("\(manager.firebaseEmail.uppercased())")
                                .bold()
                            Section {
                                ManagerRow(manager: manager)
                            }
                        }
                    }.id(UUID().uuidString)
                }
            }
        }
        .alert(item: self.$viewModel.weekError, content: { error in
            Alert(title: Text("Network Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
        })
        .navigationBarTitle(viewModel.leagueName)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: getCurrentWeek)
        .onReceive(pub) { (output) in
            self.loadUpdatedChallengers()
        }
    }
    
    func getCurrentWeek() {
            viewModel.getCurrentWeek()
            // This ultimately gets viewModel.managers
        if let user = user {
            viewModel.getLeaguesFor(user: user)
        }
    }
    
    func loadUpdatedChallengers() {
        if let user = user {
            viewModel.getLeaguesFor(user: user)
        }
    }
    
    func signOut() {
        if let authUI = FUIAuth.defaultAuthUI() {
            try? authUI.signOut()
        }
    }
    
    var signOutButton: some View {
          return Button(action: {
              self.signOut()
          }) {
              Text("Sign Out")
          }.padding(15)
            .background(LinearGradient(gradient: Gradient(colors: self.colorScheme == .light ? [.red, .black] : [.red, .gray]), startPoint: .leading, endPoint: .trailing))
              .foregroundColor(.white)
              .cornerRadius(40)
      }
    
//    func manuallyUpdateScoresForWeek() {
//        // Comment out FirebaseManager.compareScraperAndFetchScoresIfNecesary when updating manaully
//        self.firebaseObserved.getScoresFor(week: 7, post: true)
//    }
}

struct ManagerTabView_Previews: PreviewProvider {
    static var previews: some View {
        ManagerTabView(viewModel: ManagerTabViewModel())
    }
}
