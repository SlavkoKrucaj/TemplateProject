import Foundation

//sourcery: AutoMockable
public protocol TranslatorInterface {
    func translate(_ string: String) -> String
}

public struct Translator: TranslatorInterface {
    private let bundle: Bundle
    private let tableName: String

    init(bundle: Bundle = .main, tableName: String = "Localizable") {
        self.bundle = bundle
        self.tableName = tableName
    }

    public func translate(_ string: String) -> String {
        return NSLocalizedString(string, tableName: tableName, value: "**\(string)**", comment: "")
    }
}
