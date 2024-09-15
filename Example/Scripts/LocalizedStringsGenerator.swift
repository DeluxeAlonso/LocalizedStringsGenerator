import Foundation

@main
public struct LocalizedStringsGenerator {
    static func main() {
        print(CommandLine.arguments[1])
        print(CommandLine.arguments[2])
        createLocalizedStringsFile(filePath: CommandLine.arguments[1], stringsFileName: CommandLine.arguments[2])
    }

    private static func createLocalizedStringsFile(filePath: String, stringsFileName: String) {
        let fileContentString =
        """
        \(imports)

        \(localizableProtocol)

        \(stringExtension(stringsFileName))

        \(localizedStringsEnum(stringsFileName))
        """

        do {
            try fileContentString.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("LocalizedString file successfully generated:\n \(filePath)\n")
        } catch {
            print(error)
        }
    }

    private static func localizedStringsEnum(_ stringsFileName: String) -> String {
        guard let localizableStringsFileURL = findPath(for: stringsFileName) else { return "" }

            do {
                let data = try String(contentsOfFile: localizableStringsFileURL.path, encoding: .utf8)
                let stringsLine = data.components(separatedBy: .newlines).filter { $0.contains(";") && $0.contains("=") }
                print(stringsLine)
            } catch {
                print("Error: \(error)")
            }
        return ""
    }

    private static func findPath(for stringsFileName: String) -> URL? {
        let url = URL(fileURLWithPath: Bundle.main.bundlePath)
        var files = [URL]()
        guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) else {
            return nil
        }
        for case let fileURL as URL in enumerator {
            do {
                let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                if fileAttributes.isRegularFile == true, fileURL.lastPathComponent.contains(stringsFileName) {
                    files.append(fileURL)
                }
            } catch { print(error, fileURL) }
        }
        return files.first
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
