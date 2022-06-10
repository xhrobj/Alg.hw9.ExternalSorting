/// Реализация структуры данных, хранящей последовательность целых чисел
public class VirtualFileDataController: DataControllerProtocol {
    private var storage = [Int]()

    public var size: Int {
        storage.count
    }

    public var last: Int? {
        storage.last
    }

    public init(size: Int = 0) {
        createShuffleArray(size: size)
    }

    public func getData(from: Int, through: Int) -> [Int] {
        guard !storage.isEmpty else { return [] }

        var from = from, through = through
        if from > through {
            swap(&from, &through)
        }
        if from < 0 {
            from = 0
        }
        if through >= size {
            through = size - 1
        }

        return Array(storage[from...through])
    }

    @discardableResult
    public func setData(_ data: [Int], from: Int, through: Int) -> Bool {
        guard from >= 0, through >= from, through < storage.count else { return false }

        var storageNew = [Int]()
        if from > 0 {
            let to = from < size ? from : size
            storageNew = Array(storage[0..<to])
        }
        storageNew += data
        if through < storage.count - 1 {
            storageNew += Array(storage[(through + 1)...])
        }
        storage = storageNew

        return true
    }

    public func addElement(_ x: Int) {
        storage.append(x)
    }
}

extension VirtualFileDataController: CustomStringConvertible {
    public var description: String {
        "\(storage)"
    }
}

// Private methods

extension VirtualFileDataController {
    private func createShuffleArray(size: Int) {
        guard size > 0 else { return }
        storage = Array(0..<size).shuffled()
    }
}
