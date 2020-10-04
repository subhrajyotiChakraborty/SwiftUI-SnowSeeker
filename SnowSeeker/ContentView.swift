//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 30/09/20.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortedResorts = [Resort]()
    @State private var isSortByCountry = false
    @ObservedObject var favorites = Favorites()
    
    func sortResorts() {
        if isSortByCountry {
            self.sortedResorts = self.sortedResorts.sorted(by: { (lhs, rhs) -> Bool in
                lhs.country < rhs.country
            })
        } else {
            self.sortedResorts = self.sortedResorts.sorted(by: { (lhs, rhs) -> Bool in
                lhs.name < rhs.name
            })
        }
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button(self.isSortByCountry ? "Sort By Name" : "Sort By Country") {
                self.isSortByCountry.toggle()
                self.sortResorts()
            })
            .onAppear(perform: {
                self.sortedResorts = self.resorts
                self.sortedResorts = self.sortedResorts.sorted(by: { (lhs, rhs) -> Bool in
                    lhs.name < rhs.name
                })
            })
            
            
            WelcomeView()
        }
        .environmentObject(favorites)
        //        .phoneOnlyStackNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//extension View {
//    func phoneOnlyStackNavigationView() -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
//        } else {
//            return AnyView(self)
//        }
//    }
//}
