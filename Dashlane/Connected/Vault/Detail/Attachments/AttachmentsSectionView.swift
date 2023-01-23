import SwiftUI
import VaultKit
import DocumentServices
import UIDelight
import DesignSystem

struct AttachmentsSectionView: View {
    @StateObject
    var model: AttachmentsSectionViewModel

    @State
    private var showAttachmentsList: Bool = false

    var body: some View {
        Section(header: Text(L10n.Localizable.documentsStorageSectionTitle)) {
            if model.item.hasAttachments {
                LinkDetailField(title: attachmentsButtonTitle) {
                    showAttachmentsList = true
                }
                .navigation(isActive: $showAttachmentsList) {
                    model.makeAttachmentsListViewModel().map {
                        AttachmentsListView(model: $0)
                    }
                }
            }
            AddAttachmentButton(model: model.addAttachmentButtonViewModel) {
                HStack {
                    Text(addAttachmentButtonTitle)
                        .foregroundColor(color)
                    Spacer()
                    if let progress = model.progress {
                        CircularProgressBar(progress: progress,
                                            color: .ds.border.brand.standard.idle)
                        .frame(width: 20, height: 20)
                    }
                }
            }
            .disabled(model.progress != nil)
            .buttonStyle(DetailRowButtonStyle())
        }
    }

    private var addAttachmentButtonTitle: String {
        if model.item.hasAttachments {
            return L10n.Localizable.existingSecureFilesAttachedCta
        } else {
            return L10n.Localizable.noSecureFilesAttachedCta
        }
    }

    private var color: Color {
        if model.progress != nil {
            return .ds.text.oddity.disabled
        } else {
            return .ds.text.brand.standard
        }
    }

    private var attachmentsButtonTitle: String {
        let attachmentsCount: Int = model.item.attachments?.count ?? 0
        switch attachmentsCount {
        case 0, 1:
            return L10n.Localizable.oneSecureFileAttachedCta
        default:
            return L10n.Localizable.numberedSecureFilesAttachedCta(attachmentsCount)
        }
    }

}
