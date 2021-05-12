//
//  Examples.swift
//  Moonshot
//
//  Created by Arkasha Zuev on 11.05.2021.
//

import Foundation

//struct ContentView: View {
//    var body: some View {
//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
//                GeometryReader { geo in
//                    Image("Example")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: geo.size.width)
//                }
//                ForEach(0..<100) {
//                    Text("item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: Text("Detail View")) {
//                    Text("Hello world")
//                }
//            }
//            .navigationBarTitle("SwiftUI")
//        }
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail \(row + 1)")) {
//                    Text("Row \(row + 1)")
//                }
//            }
//            .navigationBarTitle(Text("SwiftUI"))
//        }
//    }
//}

//struct User: Codable {
//    var name: String
//    var address: Address
//}
//
//struct Address: Codable {
//    var street: String
//    var city: String
//}
//
//struct ContentView: View {
//    var body: some View {
//        Button("Decode JSON") {
//            let input = """
//                {
//                    "name": "Taylor Swift",
//                    "address": {
//                        "street": "555, Taylor Swift Avenue",
//                        "city": "Nashville"
//                    }
//                }
//            """
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
//    }
//}
