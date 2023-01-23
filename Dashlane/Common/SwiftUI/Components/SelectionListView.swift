import Foundation
import SwiftUI
import DashlaneAppKit
import CorePremium

struct SelectionListView<Value, Content>: View where Value: Hashable & Identifiable, Content: View {

    @Binding
    var selection: Value

    let items: [Value]
    let content: (Value) -> Content
    let selectionDidChange: () -> Void

    @Environment(\.dismiss)
    private var dismiss

    init(selection: Binding<Value>,
         items: [Value],
         selectionDidChange: @escaping () -> Void = { },
         @ViewBuilder content: @escaping (Value) -> Content) {
        self._selection = selection
        self.items = items
        self.content = content
        self.selectionDidChange = selectionDidChange
    }

    var body: some View {
        List(items, id: \.self) { item in
            HStack(spacing: 0) {
                Button(action: {
                    self.selection = item
                    self.dismiss()
                    self.selectionDidChange()
                }, label: {
                    self.content(item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                })
                if item == self.selection {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(asset: FiberAsset.accentColor))
                }
            }
        }
    }
}

extension SelectionListView where Value == UserSpace, Content == AnyView {
    init(selection: Binding<Value>,
         items: [Value],
         selectionDidChange: @escaping () -> Void = { }) {
        self.init(selection: selection, items: items, selectionDidChange: selectionDidChange, content: { userSpace in
            HStack {
                UserSpaceIcon(space: userSpace, size: .normal)
                Text(userSpace.teamName)
            }.eraseToAnyView()
        })
    }
}
