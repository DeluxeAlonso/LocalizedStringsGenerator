import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var localized: String {
        rawValue.localized(tableName: tableName)
    }

    func callAsFunction() -> String {
        localized
    }

}