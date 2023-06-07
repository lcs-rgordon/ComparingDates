import Cocoa
import SwiftDate

// Get the current date
let now = Date()

// Print the current date in various formats
print("====")
print("Current date and time is:")
print(now)
print("====")
print("Current date and time formatted in ISO8601 format is:")
print(now.formatted(.iso8601))

// Define a structure to describe current mood
struct Mood: Codable {
    let dateTime: Date
    let description: String
}

// How am I feeling?
let feeling = Mood(dateTime: now,
                   description: "Relaxed")

// What does this structure contain?
print("====")
print("Contents of original 'feeling' instance of Mood data type are:")
print(feeling)

// Create a JSON Encoder object
let encoder = JSONEncoder()

// Make sure output is easily read by humans
encoder.outputFormatting = .prettyPrinted

// Ensure dates are formatted the way we want
encoder.dateEncodingStrategy = .iso8601

// Decode the data
var encodedFeeling: Data? = nil
do {
    encodedFeeling = try encoder.encode(feeling)
} catch {
    print(error)
}

// What was encoded?
print("====")
print("Encoded contents of 'feeling' instance of Mood data type are:")
print(String(data: encodedFeeling!, encoding: .utf8)!)


// Create a JSON Decoder object
let decoder = JSONDecoder()

// Ensure that we can decode dates using format that was used to encode dates
decoder.dateDecodingStrategy = .iso8601

// Create a JSON Decoder object
var decodedFeeling: Mood? = nil
do {
    decodedFeeling = try decoder.decode(Mood.self, from: encodedFeeling!)
} catch {
    print(error)
}

// What is in this object?
print("====")
print("Decoded contents of 'decodedFeeling' instance of Mood data type are:")
print(decodedFeeling!)
print("If all has gone well, these should be identical.")

// Create some relative datetimes
let today = decodedFeeling!.dateTime
let sometimeTomorrow = today + 1.days + 5.minutes
let sometimeYesterday = today - 1.days
print("====")
print("Today is:")
print(today)
print("Sometime tomorrow is:")
print(sometimeTomorrow)
print("Sometime yesterday is:")
print(sometimeYesterday)

// Now try out some properties – these can be used as tests within an if-else statement
sometimeYesterday.isYesterday
sometimeYesterday.isToday
sometimeYesterday.isTomorrow

today.isYesterday
today.isToday
today.isTomorrow

sometimeTomorrow.isYesterday
sometimeTomorrow.isToday
sometimeTomorrow.isTomorrow

// Example of using within an if-else statement

// First create a random date sometime between 24 ago and 24 hours in future
let someDate = Date() - 1.days + Int.random(in: 0...48).hours
print("The date is: \(someDate)")
if someDate.isToday {
    print("That's today!")
} else if someDate.isYesterday {
    print("That's yesterday!")
} else if someDate.isTomorrow {
    print("That's tomorrow")
} else {
    print("I just don't know when that is!")
}
