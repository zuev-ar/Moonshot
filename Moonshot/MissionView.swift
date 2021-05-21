//
//  MissionView.swift
//  Moonshot
//
//  Created by Arkasha Zuev on 18.05.2021.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let missions: [Mission]
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: geometry.size.width * 0.7)
                    .padding(.top)
                
                Text(self.mission.formattedLaunchDate)
                
                Text(self.mission.description)
                    .padding()
                
                ForEach(self.astronauts, id: \.role) { crewMember in
                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
                
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, missions: [Mission], astronauts: [Astronaut]) {
        self.mission = mission
        self.missions = missions
        var matchs = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matchs.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matchs
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], missions: missions, astronauts: astronauts)
    }
}
