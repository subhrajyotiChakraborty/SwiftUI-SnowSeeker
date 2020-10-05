//
//  FilterOptionsView.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 05/10/20.
//

import SwiftUI

struct FilterOptionsView: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var filterByCountry: Bool
    @Binding var selectedResortSize: Int
    @Binding var selectedCountry: Int
    var resortSizes: [String]
    var countries: [String]
    var applyFilter: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    VStack {
                        Toggle("Filter By Country Name", isOn: $filterByCountry)
                        
                        if filterByCountry {
                            withAnimation {
                                Section {
                                    Picker(selection: $selectedCountry, label: Text("Country")) {
                                        ForEach(0 ..< countries.count) {
                                            Text(self.countries[$0])
                                            
                                        }
                                    }
                                }
                            }
                        } else {
                            withAnimation {
                                Section {
                                    Picker(selection: $selectedResortSize, label: Text("Resort Size")) {
                                        ForEach(0 ..< resortSizes.count) {
                                            Text(self.resortSizes[$0])
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Filter Options"))
            .navigationBarItems(trailing: Button("Done") {
                if self.filterByCountry {
                    self.selectedResortSize = 0
                } else {
                    self.selectedCountry = 0
                }
                self.applyFilter()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct FilterOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterOptionsView(filterByCountry: .constant(false), selectedResortSize: .constant(0), selectedCountry: .constant(0), resortSizes: ["1", "2", "3"], countries: ["USA", "UK"], applyFilter: {
            print("test")
        })
    }
}
