import XCTest
@testable import Geometry

final class Vector2Tests: XCTestCase {
    typealias Vector = Geometry.Vector2<Double>

    func testInit() {
        XCTAssertEqual(Vector(Point2(x: 1, y: 0)),  Vector(dx: 1, dy:  0))
        XCTAssertEqual(Vector(Angle2(degrees: 90)), .up,
                       accuracy: 1e-15)
    }

    func testStaticProperties() {
        XCTAssertEqual(Vector2.left,  Vector(dx: -1, dy:  0))
        XCTAssertEqual(Vector2.right, Vector(dx:  1, dy:  0))
        XCTAssertEqual(Vector2.up,    Vector(dx:  0, dy:  1))
        XCTAssertEqual(Vector2.down,  Vector(dx:  0, dy: -1))
    }

    func testDotProduct() {
        XCTAssertEqual(dot(.left,  .right), -1)
        XCTAssertEqual(dot(.up,    .down),  -1)
        XCTAssertEqual(dot(.left,  .up),     0)
        XCTAssertEqual(dot(.right, .down),   0)

        XCTAssertEqual(dot(Vector(dx: 2, dy: 3),
                           Vector(dx: 1, dy: 4)), 14)
    }

    func testLength() {
        XCTAssertEqual(Vector2.left.length, 1)
        XCTAssertEqual(Vector2.right.length, 1)
        XCTAssertEqual(Vector2.up.length, 1)
        XCTAssertEqual(Vector2.down.length, 1)

        XCTAssertEqual(Vector(dx: 3, dy: 4).length, 5)
    }

    func testOperators() {
        XCTAssertEqual(Vector(dx: 1, dy: 3) + Vector(dx: 2, dy: 4),
                       Vector(dx: 3, dy: 7))
        XCTAssertEqual(Vector(dx: 4, dy: 3) - Vector(dx: 2, dy: 1),
                       Vector(dx: 2, dy: 2))
        XCTAssertEqual(Vector(dx: 4, dy: 3) * 2,
                       Vector(dx: 8, dy: 6))
        XCTAssertEqual(-Vector(dx: 1, dy: 2),
                       Vector(dx: -1, dy: -2))
        XCTAssertEqual(Vector(dx: 4, dy: 6) / 2,
                       Vector(dx: 2, dy: 3))
    }

    func testInPlaceOperators() {
        var vector = Vector(dx: 1, dy: 3)

        vector += Vector(dx: 3, dy: 2)
        XCTAssertEqual(vector, Vector(dx: 4, dy: 5))

        vector -= Vector(dx: 3, dy: 2)
        XCTAssertEqual(vector, Vector(dx: 1, dy: 3))

        vector *= 12
        XCTAssertEqual(vector, Vector(dx: 12, dy: 36))

        vector /= 4
        XCTAssertEqual(vector, Vector(dx: 3, dy: 9))
    }

    func testRotate() {
        XCTAssertEqual(Vector2.right.rotated(by: 90.0), .up,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.up.rotated(by: 90.0), .left,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.left.rotated(by: 90.0), .down,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.down.rotated(by: 90.0), .right,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector(dx: 2, dy: 2).rotated(by: 105.0),
                       Vector(dx: -sqrt(6), dy: sqrt(2)),
                       accuracy: 1e-15)
        XCTAssertEqual(Vector(dx: 0.0, dy: 2.0).rotated(by: -45.0),
                       Vector(dx: sqrt(2), dy: sqrt(2)),
                       accuracy: 1e-15)
    }

    func testRotateInPlace() {
        var vector = Vector2<Double>.right

        vector.rotate(by: 90.0)
        XCTAssertEqual(vector, .up, accuracy: 1e-15)

        vector.rotate(by: 90.0)
        XCTAssertEqual(vector, .left, accuracy: 1e-15)

        vector.rotate(by: 90.0)
        XCTAssertEqual(vector, .down, accuracy: 1e-15)

        vector.rotate(by: 90.0)
        XCTAssertEqual(vector, .right, accuracy: 1e-15)
    }

    func testNormalized() {
        XCTAssertEqual(Vector(dx: 1 + 1e-8, dy: 0).normalized(), .right,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector(dx: 4, dy: 0).normalized(), .right,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector(dx: 0, dy: 5).normalized(), .up,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector(dx: 3, dy: 4).normalized(),
                       Vector(dx: 0.6, dy: 0.8),
                       accuracy: 1e-15)
    }

    func testAngleTo() {
        XCTAssertEqual(Vector2.right.angle(to: .up), 90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.up.angle(to: .left), 90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.left.angle(to: .down), 90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.down.angle(to: .right), 90.0,
                       accuracy: 1e-15)

        XCTAssertEqual(Vector2.up.angle(to: .right), -90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.left.angle(to: .up), -90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.down.angle(to: .left), -90.0,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2.right.angle(to: .down), -90.0,
                       accuracy: 1e-15)

        XCTAssertEqual(Vector2.right.rotated(by: 30.0)
            .angle(to: Vector2.right.rotated(by: 76.0)),
                       46.0, accuracy: 1e-12)
        XCTAssertEqual(Vector2.right.rotated(by: 18.0)
            .angle(to: Vector2.right.rotated(by: 123.0)),
                       105.0, accuracy: 1e-15)
        XCTAssertEqual(Vector2.right.rotated(by: 13.0)
            .angle(to: Vector2.right.rotated(by: 211.0)),
                       -162.0, accuracy: 1e-15)
    }

    func testDescription() {
        XCTAssertEqual(Vector(dx: 1.0, dy: 3.1415).description,
                       "<1.0, 3.1415>")
    }

    func testDocumentation() {
        var 🐝 = Point2(x:2, y:1), 🌻 = Point2(x:5, y:5), 👻 = Point2(x:3, y:0)

        func beeBrain() -> Vector2<Double> {
            let offsetToFlower = 🌻 - 🐝 // Vector2(dx: 3, dy: 4)
            print("🌻 is \(offsetToFlower.length) away.") // "🌻 is 5.0 away."

            let towardFlower = (🌻 - 🐝).normalized()
            let awayFromGhost = -(👻 - 🐝).normalized()

            // A weighted average of each of the bee's goals.
            var direction = (towardFlower + 2.0 * awayFromGhost) / 3.0

            // How close is this direction to the flower?
            let angleTowardFlower = direction.angle(to: towardFlower)

            // This bee doesn't move in a beeline.
            direction.rotate(by: angleTowardFlower.degrees < 0.0 ? -5.0 : 5.0)

            // Don't let gravity get you down.
            direction += .up * 0.1

            print("move 🐝", dot(direction, towardFlower), "toward 🌻")
            print("move 🐝", dot(direction, awayFromGhost), "away from 👻")

            return direction
        }

        🐝 += beeBrain() // Move the bee!
    }

    static var allTests = [
        ("testInit", testInit),
        ("testStaticProperties", testStaticProperties),
        ("testDotProduct", testDotProduct),
        ("testLength", testLength),
        ("testOperators", testOperators),
        ("testInPlaceOperators", testInPlaceOperators),
        ("testRotate", testRotate),
        ("testRotateInPlace", testRotateInPlace),
        ("testNormalized", testNormalized),
        ("testAngleTo", testAngleTo),
        ("testDescription", testDescription),
        ("testDocumentation", testDocumentation),
    ]
}
