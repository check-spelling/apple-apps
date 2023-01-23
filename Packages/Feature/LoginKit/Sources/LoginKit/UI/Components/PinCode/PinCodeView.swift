import Foundation
import SwiftUI
import UIDelight
import DesignSystem
import CoreLocalization

public struct PinCodeView: View {
    let length: Int
    let attempt: Int
    @Binding
    var errorMessage: String
    let cancelAction: () -> Void
    @Binding
    var pinCode: String {
        didSet {
            if pinCode.count > length {
                pinCode = oldValue
            }
        }
    }
    let hideCancel: Bool

    public init(pinCode: Binding<String>, errorMessage: Binding<String> = .constant(""), length: Int = 4, attempt: Int, hideCancel: Bool = false, cancelAction: @escaping () -> Void) {
        self._pinCode = pinCode
        self._errorMessage = errorMessage
        self.length = length
        self.attempt = attempt
        self.cancelAction = cancelAction
        self.hideCancel = hideCancel
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 22) {
            VStack(spacing: 16) {
                HStack(spacing: 29) {
                    ForEach(1..<5) { value in
                        Circle()
                            .stroke(Color.ds.border.neutral.standard.idle, lineWidth: 1)
                            .frame(width: 12, height: 12)
                            .background(
                                Circle()
                                    .fill(Color.ds.text.neutral.standard)
                                    .hidden(self.pinCode.count < value)
                        )
                    }
                }
                .shakeAnimation(forNumberOfAttempts: attempt)
                Text(errorMessage)
                    .foregroundColor(.ds.text.danger.quiet)
                    .font(.body)
                    .multilineTextAlignment(.center)
            }

            VStack(alignment: .trailing, spacing: 16) {

                HStack(spacing: 16) {
                    ForEach(1..<4) { value in
                        PinButton(action: {self.didClickCode(value)}, title: String(value)).font(.title)
                            .keyboardShortcut(.init(value), modifiers: [])
                    }
                }
                HStack(spacing: 16) {
                    ForEach(4..<7) { value in
                        PinButton(action: {self.didClickCode(value)}, title: String(value)).font(.title)
                            .keyboardShortcut(.init(value), modifiers: [])
                    }
                }
                HStack(spacing: 16) {
                    ForEach(7..<10) { value in
                        PinButton(action: {self.didClickCode(value)}, title: String(value)).font(.title)
                            .keyboardShortcut(.init(value), modifiers: [])
                    }
                }
                HStack(spacing: 16) {
                    PinButton(action: {}, title: "").hidden()
                    PinButton(action: {self.didClickCode(0)}, title: "0").font(.title)
                        .keyboardShortcut(.init(0), modifiers: [])
                    if pinCode.count == 0 {
                        if hideCancel {
                            cancelButton
                                .hidden()
                        } else {
                            cancelButton
                        }
                    } else {
                        deleteButton
                    }
                }
            }

        }
        .padding(.all, 16)
    }

    var cancelButton: some View {
        PinButton(action: cancelAction,
                  title: L10n.Core.cancel,
                  fillColor: .clear,
                  highlightColor: .clear)
        .keyboardShortcut(KeyEquivalent.escape, modifiers: [])
        .font(.caption)
        .foregroundColor(.ds.text.neutral.standard)
    }

    var deleteButton: some View {
        PinButton(action: {
            if !self.pinCode.isEmpty {
                _ = self.pinCode.removeLast()
            }
        }, title: L10n.Core.kwDelete, fillColor: .clear, highlightColor: .clear).font(.caption)
            .foregroundColor(.ds.text.neutral.standard)
            .keyboardShortcut(KeyEquivalent.return, modifiers: [])
    }

    func didClickCode(_ code: Int) {
        self.pinCode += String(code)
    }

}

struct PinCodeView_Previews: PreviewProvider {

    static var previews: some View {
        MultiContextPreview {
            Group {
                PinCodeView(pinCode: .constant(""), attempt: 1, cancelAction: {}).padding(.horizontal, 20).loginAppearance()
                PinCodeView(pinCode: .constant("1"), attempt: 0, cancelAction: {}).loginAppearance()
                    .frame(width: 260, height: 318)
                PinCodeView(pinCode: .constant("12"), attempt: 2, cancelAction: {}).frame(width: 200, height: 300).loginAppearance()
                PinCodeView(pinCode: .constant("123"), attempt: 2, cancelAction: {}).frame(width: 300, height: 400).loginAppearance()
                PinCodeView(pinCode: .constant("1234"), attempt: 2, cancelAction: {}).loginAppearance()
                PinCodeView(pinCode: .constant("123456789"), attempt: 2, cancelAction: {}).loginAppearance()
            }
        }.previewLayout(.sizeThatFits)

    }
}

private extension KeyEquivalent {
    init(_ intValue: Int) {
        let char = Character("\(intValue)")
        self.init(unicodeScalarLiteral: char)
    }
}
