//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 01/10/20.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Elevation: \(resort.elevation)m")
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
