//
//  ComparingDatesApp.swift
//  ComparingDates
//
//  Created by Russell Gordon on 2023-06-07.
//

import SwiftUI

@main
struct ComparingDatesApp: App {
    var body: some Scene {
        WindowGroup {
            MoodsListView()
            // Make the database available to all other view through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)

        }
    }
}
