import ExampleLibraryObjC

public class SomeApi {
    let someApiWrapper = SomeApiWrapper()

    public enum Mode {
        case Unknown
        case Idle
        case Active
    }

    internal func objCModeToMode(mode: ModeObjC) -> Mode {
        switch (mode) {
        case ModeObjC.unknown:
            return Mode.Unknown
        case ModeObjC.idle:
            return Mode.Idle
        case ModeObjC.active:
            return Mode.Active
        @unknown default:
            return Mode.Unknown
        }
    }

    public struct TwoIntegers {
        public init(first: Int32, second: Int32) {
            self.first = first
            self.second = second
        }

        var first: Int32
        var second: Int32
    }

    public init() {}

    public func poke() {
        someApiWrapper.poke()
    }

    public func echo(sendValue: String) -> String {
        return someApiWrapper.echo(sendValue)
    }

    public func add(twoIntegers: TwoIntegers) -> Int32 {
        let two_integers = TwoIntegersObjC(first: twoIntegers.first, second: twoIntegers.second)
        return someApiWrapper.add(two_integers)
    }

    public func multiply(first: Int32, second: Int32) -> Int32 {
        return someApiWrapper.multiply(first, secondNumber: second)
    }

    public func subscribeMode(callback: @escaping (Mode) -> ()) {
        someApiWrapper.subscribe_mode { mode in
            callback(self.objCModeToMode(mode: mode))
        }
    }
}
