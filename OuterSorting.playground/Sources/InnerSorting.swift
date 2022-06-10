public struct InnerSorting<Element: Comparable> {
    // https://ru.wikipedia.org/wiki/Быстрая_сортировка
    // NOTE: вариант из книжки "Грокаем алгоритмы"
    public static func quick(_ xx: [Element]) -> [Element] {
        guard xx.count > 1 else { return xx }
        guard xx.count > 2 else {
            return xx[0] > xx[1] ? [xx[1], xx[0]] : xx
        }

        var xx = xx
        let pivot = xx.popLast()!
        var left = [Element](), right = [Element]()

        for x in xx {
            if x < pivot {
                left.append(x)
            } else {
                right.append(x)
            }
        }

        return quick(left) + [pivot] + quick(right)
    }
}
