import Foundation

@main
public struct LocalizedStringsGenerator {
    static func main() {
        print("Hello world")
        print(CommandLine.arguments[1])
        let filePath = CommandLine.arguments[1]
        createLocalizedStringsFile(filePath)
    }

    private static func createLocalizedStringsFile(_ filePath: String) {
        let fileManager = FileManager.default

        let localizableProtocol =
        """
        protocol Localizable {
            var tableName: String { get }
            var localized: String { get }
        }
        """

        do {
            try localizableProtocol.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("Token Extension is successfully generated:\n \(filePath)\n")
        } catch {
            print(error)
        }
        
    }
}
