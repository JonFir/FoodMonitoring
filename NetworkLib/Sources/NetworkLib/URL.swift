import Foundation
import StandartLib

extension URL {

    static func make(rootUrl: String, path: String) throws -> URL {
        try (URL(string: rootUrl)?.appendingPathComponent(path)).value(or: NetworkError.invalidUrl)
    }

}
