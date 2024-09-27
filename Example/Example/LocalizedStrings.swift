import Foundation

protocol Localizable {
    var tableName: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        "Localizable"
    }

    func callAsFunction() -> String {
        rawValue.localized(tableName: tableName)
    }
}

private extension String {
    func localized(bundle: Bundle = .main,
                   tableName: String,
                   comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
    }
}

enum LocalizedStrings: String, Localizable {
    case helloWorld
	case byeWorld
	case bye_world
}