import XCTest
@testable import ExampleLibrary

final class ExampleLibraryTests: XCTestCase {
    func testPoke() {
        SomeApi().poke()
    }

    func testEcho() {
        XCTAssertEqual(SomeApi().echo(sendValue: "hello"), "hello")
        XCTAssertEqual(SomeApi().echo(sendValue: "some other text"), "some other text")
    }

    func testAdd() {
        let twoIntegers = SomeApi.TwoIntegers(first: 2, second: 5)
        let sum = SomeApi().add(twoIntegers: twoIntegers)

        XCTAssertEqual(7, sum)
    }

    func testMultiply() {
        let product = SomeApi().multiply(first: 7, second: 4)

        XCTAssertEqual(28, product)
    }

    func testSubscribeMode() {
        let someApi = SomeApi()
        let expectation = expectation(description: "subscribeMode triggers the callback at least once")

        someApi.subscribeMode(callback: { (mode) in expectation.fulfill() })

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Expectation errored: \(error)")
            }
        }
    }
}

