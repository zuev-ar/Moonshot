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
        GeometryReader { fullView in
            ScrollView(.vertical) {
                GeometryReader { geo in
                    ZStack(alignment: .center) {
                        if geo.frame(in: .global).minY <= 0 {
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width, height: geo.size.height - fullView.frame(in: .global).minY)
                                .offset(y: geo.frame(in: .global).minY / 8)
                        } else {
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width, height: geo.size.height + (geo.frame(in: .global).minY - fullView.frame(in: .global).minY))
                                .offset(y: 0)
                        }
                    }
                }
                .frame(height: 300)
                
                VStack {
                    Text(self.mission.formattedLaunchDate)
                        .font(.custom("AvenirNext-Regular", size: 30))
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                        .padding([.top], 20)
                    
                    Text(self.mission.description)
                        .font(.custom("AvenirNext-Regular", size: 20))
                        .lineLimit(nil)
                        .padding([.top], 20)
                    
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
                                        .font(.custom("AvenirNext-Regular", size: 20))
                                    Text(crewMember.role)
                                        .font(.custom("AvenirNext-Regular", size: 20))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                .frame(width: 350)
                .padding()
                
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
