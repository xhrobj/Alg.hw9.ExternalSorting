// https://ru.wikipedia.org/wiki/Внешняя_сортировка

public struct OuterSorting {
    static let chunkSize = 32

    public static func sort(file: VirtualFileDataController) -> (file: VirtualFileDataController, loops: Int) {
        var file = preSort(file)

        let dataSize = file.size


        var loops = 0
        while true {
            loops += 1

            let leftFile = VirtualFileDataController()
            let rightFile = VirtualFileDataController()
            var current = leftFile

            for i in 0..<dataSize {
                let x = file.getData(from: i, through: i)[0]

                guard let x1 = current.last else {
                    current.addElement(x)
                    continue
                }

                if x > x1 {
                    current.addElement(x)
                    continue
                }

                current = current === leftFile ? rightFile : leftFile

                current.addElement(x)
            }

            if leftFile.size == 0 || rightFile.size == 0 {
                break
            }

            file = merge(leftFile, rightFile)
        }

        return (file, loops)
    }
}

// Private methods

extension OuterSorting {
    private static func preSort(_ file: VirtualFileDataController) -> VirtualFileDataController {
        let dataSize = file.size

        guard chunkSize <= dataSize else { return file }

        for i in stride(from: 0, to: dataSize, by: chunkSize) {
            let firstIndex = i
            var lastIndex = i + chunkSize - 1
            if lastIndex >= dataSize {
                lastIndex = dataSize - 1
            }
            let chunk = file.getData(from: firstIndex, through: lastIndex)
            let chunkSorted = InnerSorting.quick(chunk)
            file.setData(chunkSorted, from: i, through: i + chunkSize - 1)
        }

        return file
    }

    private static func merge(
        _ leftFile: VirtualFileDataController,
        _ rightFile: VirtualFileDataController
    ) -> VirtualFileDataController {
        let mergedFile = VirtualFileDataController()

        let (leftFileSize, rightFileSize) = (leftFile.size, rightFile.size)
        var (leftFileIndex, rightFileIndex) = (0, 0)

        while leftFileIndex < leftFileSize || rightFileIndex < rightFileSize {
            if leftFileIndex >= leftFileSize {
                mergedFile.addElement(rightFile.getData(from: rightFileIndex, through: rightFileIndex)[0])
                rightFileIndex += 1
                continue
            }
            if rightFileIndex >= rightFileSize {
                mergedFile.addElement(leftFile.getData(from: leftFileIndex, through: leftFileIndex)[0])
                leftFileIndex += 1
                continue
            }

            let leftFileValue = leftFile.getData(from: leftFileIndex, through: leftFileIndex)[0]
            let rightFileValue = rightFile.getData(from: rightFileIndex, through: rightFileIndex)[0]


            if leftFileValue < rightFileValue {
                mergedFile.addElement(leftFileValue)
                leftFileIndex += 1
            } else {
                mergedFile.addElement(rightFileValue)
                rightFileIndex += 1
            }
        }

        return mergedFile
    }
}
