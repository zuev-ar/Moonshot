//
//  ContentView.swift
//  Moonshot
//
//  Created by Arkasha Zuev on 11.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State var showingCrew = false
    let astronauts: [Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, missions: missions, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showingCrew {
                            Text("mission.crewString")
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button(showingCrew == true ? "Show launch date" : "Show crew") {
                    self.showingCrew.toggle()
                }
            }
        }
    }
    
    init() {
        self.astronauts = Bundle.main.decode("astronauts.json")
        var missions: [Mission] = Bundle.main.decode("missions.json")
        
        for var mission in missions {
            var matchs = Array<String>()
            for member in mission.crew {
                if let match = astronauts.first(where: { $0.id == member.name }) {
                    matchs.append(match.name)
                }
            }
            mission.crewString = matchs.joined(separator: ", ")
        }
        
        self.missions = missions
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
