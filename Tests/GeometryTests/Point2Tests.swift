import XCTest
@testable import Geometry

final class Point2Tests: XCTestCase {
    func testInitFromVector() {
        XCTAssertEqual(Point2(Vector2(dx: 1, dy: 0)), Point2(x: 1, y: 0))
        XCTAssertEqual(Point2(Vector2(dx: 0, dy: 1)), Point2(x: 0, y: 1))
    }

    func testSubscripts() {
        var point = Point2(x: 1, y: 2)
        XCTAssertEqual(point.x, 1)
        XCTAssertEqual(point.y, 2)

        point.x = 3
        point.y = 5

        XCTAssertEqual(point.x, 3)
        XCTAssertEqual(point.y, 5)
    }

    func testOperators() {
        XCTAssertEqual(Point2(x: 1, y: 2) + Vector2(dx: 3, dy: 4),
                       Point2(x: 4, y: 6))
        XCTAssertEqual(Point2(x: 5, y: 5) - Vector2(dx: 3, dy: 4),
                       Point2(x: 2, y: 1))
        XCTAssertEqual(Point2(x: 5, y: 5) - Point2(x: 3, y: 4),
                       Vector2(dx: 2, dy: 1))
    }

    func testInPlaceOperators() {
        var point = Point2(x: 1, y: 2)

        point += Vector2(dx: 4, dy: 2)
        XCTAssertEqual(point, Point2(x: 5, y: 4))

        point -= Vector2(dx: 1, dy: 2)
        XCTAssertEqual(point, Point2(x: 4, y: 2))
    }

    func testDistance() {
        // x only
        XCTAssertEqual(Point2(x: 4, y: 2).distance(to: Point2(x: 6, y: 2)), 2)
        // y only
        XCTAssertEqual(Point2(x: 4, y: 2).distance(to: Point2(x: 4, y: 1)), 1)
        // x & y (3-4-5 triangle, so it's all integers 👌)
        XCTAssertEqual(Point2(x: 4, y: 2).distance(to: Point2(x: 7, y: 6)), 5)
    }

    func testDescription() {
        XCTAssertEqual(Point2(x: 0, y: 4.321).description, "(0.0, 4.321)")
    }

    static var allTests = [
        ("testInitFromVector", testInitFromVector),
        ("testSubscripts", testSubscripts),
        ("testOperators", testOperators),
        ("testInPlaceOperators", testInPlaceOperators),
        ("testDistance", testDistance),
        ("testDescription", testDescription),
    ]
}
