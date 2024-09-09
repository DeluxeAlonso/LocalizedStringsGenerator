import Foundation

@main
public struct LocalizedStringsGenerator {
    static func main() {
        print(CommandLine.arguments[1])
        print(CommandLine.arguments[2])
        let filePath = CommandLine.arguments[1]
        let stringsFileName = CommandLine.arguments[2]
        createLocalizedStringsFile(filePath, stringsFileName)
    }

    private static func createLocalizedStringsFile(_ filePath: String, _ stringsFileName: String) {
        let fileContentString =
        """
        \(imports)

        \(localizableProtocol)

        \(stringExtension(stringsFileName))
        """

        do {
            try fileContentString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("LocalizedString file successfully generated:\n \(filePath)\n")
        } catch {
            print(error)
        }
        
    }

    // MARK: - Utils

    static let imports =
    """
    import Foundation
    """

    static let localizableProtocol =
    """
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
    """

    static func stringExtension(_ stringsFileName: String) -> String {
        """
        private extension String {
            func localized(bundle: Bundle = .main,
                           tableName: String,
                           comment: String = "") -> String {
                NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
            }
        }
        """
    }
}
