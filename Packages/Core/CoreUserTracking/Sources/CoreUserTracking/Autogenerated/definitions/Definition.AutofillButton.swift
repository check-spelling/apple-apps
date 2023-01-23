import Foundation

extension Definition {

public enum `AutofillButton`: String, Encodable {
case `addNewItem` = "add_new_item"
case `closeCross` = "close_cross"
case `createPasswordIcon` = "create_password_icon"
case `createPasswordLabel` = "create_password_label"
case `dontShowAgain` = "dont_show_again"
case `reveal`
case `seeAllPasswords` = "see_all_passwords"
case `showOption` = "show_option"
case `shuffle`
}
}