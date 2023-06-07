//
//  MoodsListView.swift
//  ComparingDates
//
//  Created by Russell Gordon on 2023-06-07.
//

import Blackbird
import SwiftUI

struct MoodsListView: View {
    
    // MARK: Computed properties

    // The list of moods, as read from the database
    @BlackbirdLiveModels({ db in
        try await Mood.read(from: db)
    }) var moods
    
    // Is the interface to add a movie visible right now?
    @State var showingAddMoodView = false
    
    // MARK: Computed properties
    
    var body: some View {
        NavigationView {
            List(moods.results) { currentMood in
                VStack(alignment: .leading) {
                    Text("Date and time is:")
                        .bold()
                    Text("\(currentMood.dateTime.ISO8601Format())")
                        .padding(.bottom, 10)
                    Text("Feeling is:")
                        .bold()
                    Text("\(currentMood.feeling)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddMoodView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddMoodView) {
                        AddMoodView()
                            .presentationDetents([.fraction(0.3)])
                    }
                }
            }
            .navigationTitle("Moods")
        }
    }
}

struct MoodsListView_Previews: PreviewProvider {
    static var previews: some View {
        MoodsListView()
        // Make the database available to all other view through the environment
        .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
