//
//  ChallengerRow.swift
//  ChallengeApp
//
//  Created by Michael Sevy on 4/13/20.
//  Copyright © 2020 Michael Sevy. All rights reserved.
//

import SwiftUI

struct ChallengerRow: View {
    var challenger: Challenger
    @State var isPresented = false
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            HStack {
                Image(challenger.name)
                    .renderingMode(Image.TemplateRenderingMode.original)
                    .resizable()
                    .frame(width: 35, height: 35, alignment: .leading)
                    .cornerRadius(35/2)
                    .padding()
                Text(challenger.name)
                    .bold()
                Spacer()
                Text("\(scoreFor(ch: challenger))")
                    .font(.system(size: 18))
                    .frame(alignment: .topTrailing)
                    .padding()
            }
        }
    }
    
    func scoreFor(ch: Challenger) -> String {
        return String(ch.score)
    }
}


struct ChallengerRow_Preview: PreviewProvider {
    static var previews: some View {
        ChallengerRow(challenger: Challenger.genrateRandomChallenger())
    }
}
