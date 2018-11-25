import XCTest
@testable import Geometry

final class Point2Tests: XCTestCase {
    typealias Point = Geometry.Point2<Double>

    func testInitFromVector() {
        XCTAssertEqual(Point(Vector2(dx: 1, dy: 0)), Point(x: 1, y: 0))
        XCTAssertEqual(Point(Vector2(dx: 0, dy: 1)), Point(x: 0, y: 1))
    }

    func testSubscripts() {
        var point = Point(x: 1, y: 2)
        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)

        point.x = 3
        point.y = 5

        XCTAssertEqual(point.x, 3)
        XCTAssertEqual(point.y, 5)
    }

    func testOperators() {
        XCTAssertEqual(Point(x: 1, y: 2) + Vector2(dx: 3, dy: 4),
                       Point(x: 4, y: 6))
        XCTAssertEqual(Point(x: 5, y: 5) - Vector2(dx: 3, dy: 4),
                       Point(x: 2, y: 1))
        XCTAssertEqual(Point(x: 5, y: 5) - Point(x: 3, y: 4),
                       Vector2(dx: 2, dy: 1))
    }

    func testInPlaceOperators() {
        var point = Point(x: 1, y: 2)

        point += Vector2(dx: 4, dy: 2)
        XCTAssertEqual(point, Point(x: 5, y: 4))

        point -= Vector2(dx: 1, dy: 2)
        XCTAssertEqual(point, Point(x: 4, y: 2))
    }

    func testDistance() {
        // x only
        XCTAssertEqual(Point(x: 4, y: 2).distance(to: Point(x: 6, y: 2)), 2)
        // y only
        XCTAssertEqual(Point(x: 4, y: 2).distance(to: Point(x: 4, y: 1)), 1)
        // x & y (3-4-5 triangle, so it's all integers 👌)
        XCTAssertEqual(Point(x: 4, y: 2).distance(to: Point(x: 7, y: 6)), 5)
    }

    func testDescription() {
        XCTAssertEqual(Point(x: 0, y: 4.321).description, "(0.0, 4.321)")
    }

    func testDocumentation() {
        var point = Point2(x: 10, y: 20)

        point.x = 15
        print("Point:", point) // "Point: (x: 15.0, y: 20.0)"

        print("Distance:", point.distance(to: .zero)) // "Distance: 25.0"
    }

    static var allTests = [
        ("testInitFromVector", testInitFromVector),
        ("testSubscripts", testSubscripts),
        ("testOperators", testOperators),
        ("testInPlaceOperators", testInPlaceOperators),
        ("testDistance", testDistance),
        ("testDescription", testDescription),
        ("testDocumentation", testDocumentation),
    ]
}
