//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Subhrajyoti Chakraborty on 03/10/20.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = paths[0].appendingPathComponent(saveKey)
        do {
            let data = try Data(contentsOf: filePath)
            let decodedData = try JSONDecoder().decode(Set<String>.self, from: data)
            self.resorts = decodedData
            return
        } catch  {
            print("Unable to load data")
        }

        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
        let filePath = getFilePath().appendingPathComponent(saveKey)
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: filePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save the data")
        }
    }
    
    func getFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
