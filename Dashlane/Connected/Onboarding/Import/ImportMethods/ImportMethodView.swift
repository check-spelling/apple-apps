import SwiftUI
import UIDelight
import DashlaneAppKit
import UIComponents
import DesignSystem

struct ImportMethodView<Model: ImportMethodViewModelProtocol>: View {

    @ObservedObject
    var viewModel: Model

    var body: some View {
        FullScreenScrollView {
            VStack(spacing: 8) {

                                if viewModel.shouldShowDWMScanResult {
                    darkWebMonitoringResults
                        .padding()
                }

                                if viewModel.shouldShowDWMScanPrompt {
                    Infobox(title: L10n.Localizable.darkWebMonitoringOnboardingScanPromptTitle,
                            description: L10n.Localizable.darkWebMonitoringOnboardingScanPromptDescription) {
                        Button(action: viewModel.startDWMScan,
                               title: L10n.Localizable.darkWebMonitoringOnboardingScanPromptScan)
                        Button(action: viewModel.dismissLastChanceScanPrompt,
                               title: L10n.Localizable.darkWebMonitoringOnboardingScanPromptIgnore)
                    }
                    .padding(8)
                    .padding()
                }

                Form {
                    ForEach(viewModel.sections) { section in
                        Section(header:
                            Text(section.header ?? "")
                                .padding(.top, 16)
                        ) {
                            ForEach(section.items) { method in
                                ImportMethodItemView(importMethod: method)
                                    .padding(.vertical, 13.0)
                                    .contentShape(Rectangle())
                                    .onTapWithFeedback {
                                        self.viewModel.methodSelected(method)
                                    }
                            }
                        }
                    }
                }
            }
        }
        .backgroundColorIgnoringSafeArea(Color(asset: FiberAsset.appBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBarButton(L10n.Localizable.kwBack, action: viewModel.back)
            }
        }
        .navigationTitle(viewModel.shouldShowDWMScanResult ? L10n.Localizable.dwmOnboardingFixBreachesMainTitle : "")
        .reportPageAppearance(.import)
        .onAppear {
            viewModel.logDisplay()
        }
    }

        private var darkWebMonitoringResults: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(asset: FiberAsset.noBreachesMessageIcon)
                .fiberAccessibilityHidden(true)
            VStack(alignment: .leading, spacing: 10) {
                Text(L10n.Localizable.darkWebMonitoringOnboardingResultsNoBreachesTitle)
                    .foregroundColor(Color(asset: FiberAsset.dwmOnboardingResultMessageText))
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                Text(L10n.Localizable.darkWebMonitoringOnboardingResultsNoBreachesBody)
                    .foregroundColor(Color(asset: FiberAsset.dwmOnboardingResultMessageText))
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(asset: FiberAsset.iconPlaceholderBackground))
        .cornerRadius(4)
        .padding(.horizontal, 8)
        .padding(.top, 24)
        .fiberAccessibilityElement(children: .combine)
        .fiberAccessibilityLabel(Text("\(L10n.Localizable.accessibilityInfoSection): \(L10n.Localizable.darkWebMonitoringOnboardingResultsNoBreachesTitle), \(L10n.Localizable.darkWebMonitoringOnboardingResultsNoBreachesBody)"))
    }
}

struct ImportMethodView_Previews: PreviewProvider {

    class FakeModel: ImportMethodViewModelProtocol {
        var shouldShowDWMScanPrompt: Bool
        var shouldShowDWMScanResult: Bool
        var sections: [ImportMethodSection]
        var completion: (ImportMethodCompletion) -> Void

        init(importService: ImportMethodServiceProtocol, shouldShowDWMScanPrompt: Bool = false, shouldShowDWMScanResult: Bool = false) {
            self.shouldShowDWMScanPrompt = shouldShowDWMScanPrompt
            self.shouldShowDWMScanResult = shouldShowDWMScanResult
            sections = importService.methods
            completion = { _ in }
        }

        func logDisplay() {}
        func dismissLastChanceScanPrompt() {}
        func startDWMScan() {}
        func methodSelected(_ method: ImportMethod) {}
        func back() {}
    }

    static var previews: some View {
        MultiContextPreview {
            Group {
                NavigationView {
                    ImportMethodView(viewModel: FakeModel(importService: ImportMethodService.mock(for: .firstPassword)))
                }
                NavigationView {
                    ImportMethodView(viewModel: FakeModel(importService: ImportMethodService.mock(for: .browser)))
                }
                NavigationView {
                    ImportMethodView(viewModel: FakeModel(importService: ImportMethodService.mock(for: .firstPassword), shouldShowDWMScanPrompt: true))
                }
                NavigationView {
                    ImportMethodView(viewModel: FakeModel(importService: ImportMethodService.mock(for: .firstPassword), shouldShowDWMScanResult: true))
                }
            }
        }
    }
}
