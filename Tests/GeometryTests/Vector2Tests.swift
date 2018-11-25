import XCTest
@testable import Geometry

final class Vector2Tests: XCTestCase {
    typealias Vector2 = Geometry.Vector2<Double>

    func testInit() {
        XCTAssertEqual(Vector2(Point2(x: 1, y: 0)),  Vector2(dx: 1, dy:  0))
        XCTAssertEqual(Vector2(Angle(degrees: 90)), .up,
                       accuracy: 1e-15)
    }

    func testStaticProperties() {
        XCTAssertEqual(Vector2.left,  Vector2(dx: -1, dy:  0))
        XCTAssertEqual(Vector2.right, Vector2(dx:  1, dy:  0))
        XCTAssertEqual(Vector2.up,    Vector2(dx:  0, dy:  1))
        XCTAssertEqual(Vector2.down,  Vector2(dx:  0, dy: -1))
    }

    func testDotProduct() {
        XCTAssertEqual(dot(.left,  .right), -1)
        XCTAssertEqual(dot(.up,    .down),  -1)
        XCTAssertEqual(dot(.left,  .up),     0)
        XCTAssertEqual(dot(.right, .down),   0)

        XCTAssertEqual(dot(Vector2(dx: 2, dy: 3),
                           Vector2(dx: 1, dy: 4)), 14)
    }

    func testLength() {
        XCTAssertEqual(Vector2.left.length, 1)
        XCTAssertEqual(Vector2.right.length, 1)
        XCTAssertEqual(Vector2.up.length, 1)
        XCTAssertEqual(Vector2.down.length, 1)

        XCTAssertEqual(Vector2(dx: 3, dy: 4).length, 5)
    }

    func testOperators() {
        XCTAssertEqual(Vector2(dx: 1, dy: 3) + Vector2(dx: 2, dy: 4),
                       Vector2(dx: 3, dy: 7))
        XCTAssertEqual(Vector2(dx: 4, dy: 3) - Vector2(dx: 2, dy: 1),
                       Vector2(dx: 2, dy: 2))
        XCTAssertEqual(Vector2(dx: 4, dy: 3) * 2,
                       Vector2(dx: 8, dy: 6))
        XCTAssertEqual(-Vector2(dx: 1, dy: 2),
                       Vector2(dx: -1, dy: -2))
        XCTAssertEqual(Vector2(dx: 4, dy: 6) / 2,
                       Vector2(dx: 2, dy: 3))
    }

    func testInPlaceOperators() {
        var vector = Vector2(dx: 1, dy: 3)

        vector += Vector2(dx: 3, dy: 2)
        XCTAssertEqual(vector, Vector2(dx: 4, dy: 5))

        vector -= Vector2(dx: 3, dy: 2)
        XCTAssertEqual(vector, Vector2(dx: 1, dy: 3))

        vector *= 12
        XCTAssertEqual(vector, Vector2(dx: 12, dy: 36))

        vector /= 4
        XCTAssertEqual(vector, Vector2(dx: 3, dy: 9))
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
        XCTAssertEqual(Vector2(dx: 2, dy: 2).rotated(by: 105.0),
                       Vector2(dx: -sqrt(6), dy: sqrt(2)),
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2(dx: 0.0, dy: 2.0).rotated(by: -45.0),
                       Vector2(dx: sqrt(2), dy: sqrt(2)),
                       accuracy: 1e-15)
    }

    func testRotateInPlace() {
        var vector = Vector2.right

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
        XCTAssertEqual(Vector2(dx: 1 + 1e-8, dy: 0).normalized(), .right,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2(dx: 4, dy: 0).normalized(), .right,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2(dx: 0, dy: 5).normalized(), .up,
                       accuracy: 1e-15)
        XCTAssertEqual(Vector2(dx: 3, dy: 4).normalized(),
                       Vector2(dx: 0.6, dy: 0.8),
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
        XCTAssertEqual(Vector2(dx: 1.0, dy: 3.1415).description,
                       "<1.0, 3.1415>")
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
    ]
}
