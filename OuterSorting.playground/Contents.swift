//let fileSizes = [10, 100, 1000, 10_000, 100_000, 1_000_000]

let fileSize = 100

let file = VirtualFileDataController(size: fileSize)
print(file, "\n")

let fileSorted = OuterSorting.sort(file: file)
print(fileSorted.file, "\n")

print("Файл размера \(file.size) отсортирован за", fileSorted.loops, "слияний")
