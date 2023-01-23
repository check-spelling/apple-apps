import Foundation
import SwiftUI
import Combine

public struct OTPField: View {

    @StateObject
    var model: OTPFieldModel

    @Binding
    var otpValue: String

    @Binding
    var isError: Bool

    var otp: [Binding<String>] {
        [$model.otp1, $model.otp2, $model.otp3, $model.otp4, $model.otp5, $model.otp6]
    }

    @State private var numberOfCells: Int = 6
    @State private var currentlySelectedCell = 0

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<6) { index in
                OTPCell(textValue: otp[index], currentlySelectedCell: self.$currentlySelectedCell, otp: otp, index: index)
                    .overlay(RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(isError ? .ds.border.danger.standard.idle : Color.clear, lineWidth: 1))
            }
        }.onReceive(model.updatePublisher) {
            update()
        }
    }

    func update() {
        otpValue = model.otp1 + model.otp2 + model.otp3 + model.otp4 + model.otp5 + model.otp6
    }
}

struct OTPField_Previews: PreviewProvider {
    static var previews: some View {
        OTPField(model: OTPFieldModel(), otpValue: .constant(""), isError: .constant(false))
        OTPField(model: OTPFieldModel(), otpValue: .constant(""), isError: .constant(true))
    }
}

class OTPFieldModel: ObservableObject {

    var updatePublisher = PassthroughSubject<Void, Never>()

    @Published
    var otp1: String = "" {
        didSet {
            update()
        }
    }

    @Published
    var otp2: String = "" {
        didSet {
            update()
        }
    }

    @Published
    var otp3: String = "" {
        didSet {
            update()
        }
    }

    @Published
    var otp4: String = "" {
        didSet {
            update()
        }
    }

    @Published
    var otp5: String = "" {
        didSet {
            update()
        }
    }

    @Published
    var otp6: String = "" {
        didSet {
            update()
        }
    }

    func update() {
        updatePublisher.send()
    }
}

struct OTPCell: View {
    @Binding var textValue: String
    @Binding var currentlySelectedCell: Int
    let otp: [Binding<String>]
    var index: Int

    var responder: Bool {
        return index == currentlySelectedCell
    }

    var body: some View {
        OTPTextField(text: $textValue, currentlySelectedCell: $currentlySelectedCell, otp: otp, isFirstResponder: responder)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
            .frame(width: 48, height: 65, alignment: .center)
            .background(.ds.container.agnostic.neutral.quiet)
            .clipShape(Rectangle())
            .cornerRadius(5)
            .font(.title)
            .monospacedDigit()
            .lineLimit(1)
    }
}

struct OTPTextField: UIViewRepresentable {

    class Coordinator: NSObject, UITextFieldDelegate {

        @Binding var text: String
        @Binding var currentlySelectedCell: Int
        let otp: [Binding<String>]

        var didBecomeFirstResponder = false

        init(text: Binding<String>, currentlySelectedCell: Binding<Int>, otp: [Binding<String>]) {
            _text = text
            _currentlySelectedCell = currentlySelectedCell
            self.otp = otp
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.text = textField.text ?? ""
            }
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""

            guard let stringRange = Range(range, in: currentText) else { return false }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            if updatedText.count <= 1 {
                self.currentlySelectedCell += 1
            } else {
                var current = updatedText
                otp.forEach { value in
                    if let string = current.first {
                        value.wrappedValue = String(string)
                        current = String(current.dropFirst())
                        self.currentlySelectedCell += 1
                    }
                }
            }

            return updatedText.count <= 1
        }
    }

    @Binding var text: String
    @Binding var currentlySelectedCell: Int
    let otp: [Binding<String>]

    var isFirstResponder: Bool = false

    func makeUIView(context: UIViewRepresentableContext<OTPTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.font = .monospacedDigitSystemFont(ofSize: 32, weight: .medium)
        return textField
    }

    func makeCoordinator() -> OTPTextField.Coordinator {
        return Coordinator(text: $text, currentlySelectedCell: $currentlySelectedCell, otp: otp)
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<OTPTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
