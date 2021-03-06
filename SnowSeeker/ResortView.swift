//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 01/10/20.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment (\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text("\(resort.imageCredit)")
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .clipShape(Rectangle())
                        .offset(x: -0, y: -0)
                }
                
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack(alignment: .leading) { ResortDetailsView(resort: resort) }
                            VStack(alignment: .leading) { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer()
                                .frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                        
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    
                    Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                        if self.favorites.contains(self.resort) {
                            self.favorites.remove(self.resort)
                        } else {
                            self.favorites.add(self.resort)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
