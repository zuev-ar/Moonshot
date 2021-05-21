//
//  ContentView.swift
//  Moonshot
//
//  Created by Arkasha Zuev on 11.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State var showingCrew = false
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
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
                            Text(getCrewNames(mission: mission))
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button(showingCrew == true ? "Launch date" : "Crew names") {
                    self.showingCrew.toggle()
                }
            }
        }
    }
    
    func getCrewNames(mission: Mission) -> String {
        var matchs = Array<String>()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matchs.append(match.name)
            }
        }
        
        return matchs.joined(separator: ", ")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
