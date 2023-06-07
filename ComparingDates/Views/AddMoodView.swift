//
//  AddMoodView.swift
//  ComparingDates
//
//  Created by Russell Gordon on 2023-06-07.
//

import Blackbird
import SwiftUI

struct AddMoodView: View {
    // MARK: Stored properties
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
        
    // Holds details for the new movie
    @State var feeling = ""
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                TextField("How are you feeling?", text: $feeling)
                    .textFieldStyle(.roundedBorder)

                Spacer()
            }
            .padding(5)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        addMood()
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
    
    // MARK: Functions
    
    func addMood() {
        // Write to database
        Task {
            try await db!.transaction { core in
                try core.query("""
                            INSERT INTO mood (
                                dateTime,
                                feeling
                            )
                            VALUES (
                                (?),
                                (?)
                            )
                            """,
                            Date(),
                            feeling)
            }
            // Reset input fields after writing to database
            feeling = ""
        }

    }
}

struct AddMoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoodView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
