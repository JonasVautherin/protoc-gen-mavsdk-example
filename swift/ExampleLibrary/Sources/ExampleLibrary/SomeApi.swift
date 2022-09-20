import ExampleLibraryObjC

public class SomeApi {
    let someApiObjC = SomeApiObjC()

    public enum Mode {
        /// Mode unknown
        case unknown
        /// Mode 'idle'
        case idle
        /// Mode 'active'
        case active
    }

    func modeObjCToMode(_ mode: ModeObjC) -> Mode {
        switch (mode) {
        case .unknown:
            return .unknown
        case .idle:
            return .idle
        case .active:
            return .active
        @unknown default:
            return .unknown
        }
    }

    /// Struct containing integers to add
    public struct TwoIntegers {
        public init(first: Int32, second: Int32) {
            self.first = first
            self.second = second
        }

        /// First integer
        let first: Int32
        /// Second integer
        let second: Int32
    }

    func twoIntegersToTwoIntegersObjC(_ twoIntegers: TwoIntegers) -> TwoIntegersObjC {
        return TwoIntegersObjC(first: twoIntegers.first, second: twoIntegers.second)
    }

    public init() {}

    /// Call a function (that may have side effects)
    public func poke() {
        return someApiObjC.poke()
    }

    /// Send a value to be echoed back
    public func echo(sendValue: String) -> String {
        let sendValueObjC = sendValue

        return someApiObjC.echo(sendValueObjC)
    }

    /// Add two numbers and return the result
    public func add(twoIntegers: TwoIntegers) -> Int32 {
        let twoIntegersObjC = twoIntegersToTwoIntegersObjC(twoIntegers)

        return someApiObjC.add(twoIntegersObjC)
    }

    /// Multiply two numbers and return the result
    public func multiply(first: Int32, second: Int32) -> Int32 {
        let firstObjC = first
        let secondObjC = second

        return someApiObjC.multiply(firstObjC, secondObjC)
    }

    /// Subscribe to 'mode' updates.
    public func subscribeMode(callback: @escaping (Mode) -> ()) {
        someApiObjC.subscribeMode { [weak self] event in
            guard let strongSelf = self else {
                return
            }

            callback(strongSelf.modeObjCToMode(event))
        }
    }
}