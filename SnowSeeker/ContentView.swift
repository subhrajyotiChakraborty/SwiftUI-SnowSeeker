//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 30/09/20.
//

import SwiftUI

struct ContentView: View {
    
    // Working with two side by side views in SwiftUI
    
    //    var body: some View {
    //        NavigationView {
    //            NavigationLink(destination: Text("New secondary")) {
    //                Text("Hello, World!")
    //            }
    //            .navigationBarTitle("Primary")
    //
    //            Text("Secondary")
    //        }
    //    }
    
    
    // Using alert() and sheet() with optionals
    
    //    @State private var selectedUser: User? = nil
    //
    //    var body: some View {
    //        Text("Hello, World!")
    //            .onTapGesture {
    //                self.selectedUser = User()
    //            }
    //            .alert(item: $selectedUser) { (user) -> Alert in
    //                Alert(title: Text(user.id))
    //            }
    //    }
    
    
    // Using groups as transparent layout containers
    
    @Environment (\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Group {
            if sizeClass == .compact {
                //                VStack {
                //                    UserView()
                //                }
                // In situations like this, where you have only one view inside a stack and it doesn’t take any parameters, you can pass the view’s initializer directly to the VStack to make your code shorter:
                VStack (content: UserView.init)
            } else {
                //                HStack {
                //                    UserView()
                //                }
                HStack (content: UserView.init)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Text("Hello World")
    }
}
