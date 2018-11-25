![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)

# Geometry

This library defines three generic equatable types [Point2](#point2), [Angle](#angle), and [Vector2](#vector2).

## Installation

This is currently pre-release, but you can use it with **Swift Package Manager** from master by setting your `Package.swift` like this:

```swift
// swift-tools-version:4.2

import PackageDescription

let package2 = Package(
  name: "MyProject",
  dependencies: [
    .package(url: "https://github.com/therealbnut/Geometry.git", .branch("master"))
  ],
  targets: []
)
```

## Types

### Vector2

`Vector2<Scalar>` defines an angle between in 2-dimensional space. It is the most versatile type in this library. 

You can use it like this:

```swift
var 🐝 = Point2(x:2, y:1), 🌻 = Point2(x:5, y:5), 👻 = Point2(x:3, y:0)

let offsetToFlower = 🌻 - 🐝 // Vector2(dx: 3, dy: 4)
print("🌻 is \(offsetToFlower.length) away.") // "🌻 is 5.0 away."

let towardFlower = (🌻 - 🐝).normalized()
let awayFromGhost = -(👻 - 🐝).normalized()

var direction = (towardFlower + 2.0 * awayFromGhost) / 3.0

// How close is this direction to the flower?
let angleTowardFlower = direction.angle(to: towardFlower)

// This bee doesn't move in a beeline.
direction.rotate(by: angleTowardFlower.degrees < 0.0 ? -5.0 : 5.0)

// Don't let gravity get you down.
direction += .up * 0.1

🐝 += direction // Move the bee!

print("🐝 moved", dot(direction, towardFlower), "toward 🌻") // "🐝 moved 0.56 toward 🌻"
print("🐝 moved", dot(direction, awayFromGhost), "away from 👻") // "🐝 moved 0.75 away from 👻"
```

### Point2

`Point2<Scalar>` defines a position in 2-dimensional space.
You can use it like this: 

```swift
var point = Point2(x: 10, y: 20)

point.x = 15
print("Point:", point) // "Point: (x: 15.0, y: 20.0)"

print("Distance:", point.distance(to: .zero)) // "Distance: 25.0"
```

### Angle

`Angle2<Scalar>` defines an angle between in 2-dimensional space. 
You can use it like this:

```swift
var angle = Angle(degrees: 15.0)
angle += 90.0
angle += Angle(radians: .pi)
angle = -angle * 1.5

print("\(angle) (\(angle.radians) radians)") // "112.5º (1.9634954084936211 radians)"

print(cos(Angle(degrees: 60.0))) // "0.5"
print(sin(Angle(degrees: 90.0))) // "1.0"
```
