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
    @State private var showFilterOptions = false
    @State private var selectedCountry = 0
    @State private var selectedResortSize = 0
    @State private var countries = ["All", "France", "Italy", "Canada", "Austria", "United States"]
    @State private var isFilterApplied = false
    @State private var filterByCountry = false
    @ObservedObject var favorites = Favorites()
    let resortSizeArray = ["All", "Small", "Medium", "Large"]
    
    func applyFilter() {
        
        isFilterApplied = true
        
        if selectedCountry != 0 {
            self.sortedResorts = self.resorts.filter { (resort) -> Bool in
                resort.country == countries[selectedCountry]
            }
        }
        
        if selectedResortSize != 0 {
            self.sortedResorts = self.resorts.filter { (resort) -> Bool in
                resort.size == selectedResortSize
            }
        }
        
        if selectedCountry == 0 && selectedResortSize == 0 {
            self.sortedResorts = self.resorts
        }
    }
    
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
    
    func onLoad() {
        self.sortedResorts = self.resorts
        self.sortedResorts = self.sortedResorts.sorted(by: { (lhs, rhs) -> Bool in
            lhs.name < rhs.name
        })
        
        if isFilterApplied {
            applyFilter()
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
            .navigationBarItems(leading: Button("Filter") {
                self.showFilterOptions.toggle()
            }, trailing: Button(action: {
                self.isSortByCountry.toggle()
                self.sortResorts()
            }, label: {
                if self.isSortByCountry {
                    Image(systemName: "arrow.up.arrow.down.circle")
                    Text("Name")
                } else {
                    Image(systemName: "arrow.up.arrow.down.circle")
                    Text("Country")
                }
            }))
            .onAppear(perform: {
                self.onLoad()
            })
            .sheet(isPresented: $showFilterOptions, content: {
                FilterOptionsView(filterByCountry: self.$filterByCountry, selectedResortSize: self.$selectedResortSize, selectedCountry: self.$selectedCountry, resortSizes: self.resortSizeArray, countries: self.countries, applyFilter: {
                    self.applyFilter()
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
