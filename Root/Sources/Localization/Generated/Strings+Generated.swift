// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Составное блюдо
  public static var createFoodChoiceSheetComplexDish: String { return L10n.tr("Localizable", "create_food_choice_sheet_complex_dish") }
  /// Простое блюдо
  public static var createFoodChoiceSheetSimpleDish: String { return L10n.tr("Localizable", "create_food_choice_sheet_simple_dish") }
  /// Ничего не найдено
  public static var foodDataSearchScreenEmptyResultLabel: String { return L10n.tr("Localizable", "food_data_search_screen_empty_result_label") }
  /// Введите запрос
  public static var foodDataSearchScreenStartSearchHint: String { return L10n.tr("Localizable", "food_data_search_screen_start_search_hint") }
  /// Поиск продуктов
  public static var foodDataSearchScreenTitle: String { return L10n.tr("Localizable", "food_data_search_screen_title") }
  /// Привет мир
  public static var hello: String { return L10n.tr("Localizable", "hello") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.safeModule.localized(key, table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
