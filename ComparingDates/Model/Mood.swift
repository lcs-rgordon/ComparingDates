//
//  Mood.swift
//  ComparingDates
//
//  Created by Russell Gordon on 2023-06-07.
//

import Blackbird
import Foundation

struct Mood: BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var dateTime: Date
    @BlackbirdColumn var feeling: String
}
