# Spell List Database SPM

## Intro

Simple package which wraps an SQLite database containing Pathfinder 1e spells.

This package assumes the developer has some knowledge of the Pathfinder RPG.

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftridiak%2FSpellSPM%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/tridiak/SpellSPM)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftridiak%2FSpellSPM%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/tridiak/SpellSPM)

## Installation

### SPM

In XCode, ```File > Swift Packages > Add Package Dependency```.

## Structs and Classes

Main classes and structs.

```swift
actor SpellDBAccess
```

Class that that accesses the SQLite database. Uses C api.

```swift
class Spell
```

Class that contains the metadata for a spell. Has an extension which provides a lot of convenince accessors.

```swift
actor SpellStorage
```

Simple storage class for the Spell class.

```swift
struct SpellFields
```

Struct with properties that match the SQLite database spell columns.

```
extension StringStuff
```

Utility methods for String.

## Usage

Download macOS demo app [here](https://github.com/tridiak/SPMTestApp.git) demonstrating basic usage of the SPM.

From the demo app:

```swift
struct SpellData : Identifiable {
	let id = UUID()
	let name : String
	var school : SpellSPM.SpellSchools? = nil
}

@MainActor
@Observable
class SpellListModel {
	let spellStore : SpellSPM.SpellStorage
	let db : SpellSPM.SpellDBAccess
	
	init() {
		spellStore = try! SpellStorage()
		db = try! SpellSPM.SpellDBAccess()
	}
	
	var spells : [SpellData] = []
	
	func reloadSpells() {
		Task {
			guard let s = try? await db.getAllNames(force: true) else { return }
			self.spells = s.map({ S in
				return SpellData(name: S)
			})
		}
	}
}
```

