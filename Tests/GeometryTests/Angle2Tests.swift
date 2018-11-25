import XCTest
@testable import Geometry

final class AngleTests: XCTestCase {
    typealias Angle = Geometry.Angle2<Double>

    public func testInitializers() {
        XCTAssertEqual(Angle(degrees: 90), Angle(.up), accuracy: 1e-15)
        XCTAssertEqual(Angle(radians: .pi), Angle(.left), accuracy: 1e-15)
        XCTAssertEqual(37.0, Angle(degrees: 37.0), accuracy: 1e-15)
    }

    public func testOperators() {
        XCTAssertEqual(Angle(degrees: 10.0) + 20.0, 30.0, accuracy: 1e-12)
        XCTAssertEqual(Angle(degrees: 45.0) - 30.0, 15.0, accuracy: 1e-12)
        XCTAssertEqual(Angle(degrees: 45.0) * 6.0, -90.0, accuracy: 1e-12)
        XCTAssertEqual(-Angle(degrees: 47.0), -47.0, accuracy: 1e-15)
    }

    public func testInPlaceOperators() {
        var angle: Angle = 10.0

        angle += 35.0
        XCTAssertEqual(angle, 45.0, accuracy: 1e-12)

        angle -= 15.0
        XCTAssertEqual(angle, 30.0, accuracy: 1e-12)

        angle *= 3.0
        XCTAssertEqual(angle, 90.0, accuracy: 1e-12)
    }

    public func testCumulativeError() {
        var output: Angle = 0.0
        let angle1: Angle = 100.0
        let angle2: Angle = 28.0
        let angle3: Angle = 232.0
        measure {
            for _ in 1 ... 100_000 {
                output += angle1
                output += angle2
                output += angle3
            }
        }
        XCTAssertEqual(output, 0.0, accuracy: 1e-14)
    }

    public func testScalarConversions() {
        XCTAssertEqual((30.0 as Angle).degrees, 30.0,
                       accuracy: 1e-12)
        XCTAssertEqual((-76.0 as Angle).degrees, -76.0,
                       accuracy: 1e-12)

        XCTAssertEqual((30.0 as Angle).radians, .pi / 6.0,
                       accuracy: 1e-12)
        XCTAssertEqual((25.7142857143 as Angle).radians, .pi / 7.0,
                       accuracy: 1e-12)
    }

    public func testTrigFunctions() {
        XCTAssertEqual(cos(30.0 as Angle), sqrt(3)/2.0, accuracy: 1e-15)
        XCTAssertEqual(cos(60.0 as Angle), 0.5, accuracy: 1e-15)
        XCTAssertEqual(cos(45.0 as Angle), sqrt(2)/2.0, accuracy: 1e-15)

        XCTAssertEqual(sin(30.0 as Angle), 0.5, accuracy: 1e-15)
        XCTAssertEqual(sin(60.0 as Angle), sqrt(3)/2.0, accuracy: 1e-15)
        XCTAssertEqual(sin(45.0 as Angle), sqrt(2)/2.0, accuracy: 1e-15)
    }

    public func testDescription() {
        XCTAssertEqual(Angle(degrees: 90).description, "90.0º")
    }

    public func testDocumentation() {
        var angle = Angle(degrees: 15.0)
        angle += 90.0
        angle += Angle(radians: .pi)
        angle = -angle * 1.5

        print("\(angle) (\(angle.radians) radians)") // "112.5º (1.9634954084936211 radians)"

        print(cos(Angle(degrees: 60.0))) // "0.5"
        print(sin(Angle(degrees: 90.0))) // "1.0"
    }

    static var allTests = [
        ("testInitializers", testInitializers),
        ("testOperators", testOperators),
        ("testInPlaceOperators", testInPlaceOperators),
        ("testCumulativeError", testCumulativeError),
        ("testScalarConversions", testScalarConversions),
        ("testTrigFunctions", testTrigFunctions),
        ("testDescription", testDescription),
        ("testDocumentation", testDocumentation),
        ]
}
