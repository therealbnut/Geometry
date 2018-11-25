import XCTest

import mathTests

var tests = [XCTestCaseEntry]()
tests += mathTests.allTests()
XCTMain(tests)