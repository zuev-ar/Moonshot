//
//  AstronautView.swift
//  Moonshot
//
//  Created by Arkasha Zuev on 18.05.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let listOfMissions: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text(self.listOfMissions)
                        .font(.custom("AvenirNext-Bold", size: 20))
                        .padding([.top], 30)
                    Text(self.astronaut.description)
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .padding([.top], 20)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var arrayOfMissions = Array<String>()
        
        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                arrayOfMissions.append(mission.displayName)
            }
        }
        
        self.listOfMissions = "Missions: " + arrayOfMissions.joined(separator: ", ")
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
