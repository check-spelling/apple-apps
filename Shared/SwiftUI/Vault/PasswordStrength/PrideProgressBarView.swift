import Foundation
import SwiftUI
import Combine

struct PrideProgressBarView: View {
    let progress: CGFloat
    let total: CGFloat

    let fillColor: Color
    let backgroundColor: Color
    let prideColors = [Color(asset: SharedAsset.pride1),
                       Color(asset: SharedAsset.pride2),
                       Color(asset: SharedAsset.pride3),
                       Color(asset: SharedAsset.pride4),
                       Color(asset: SharedAsset.pride5),
                       Color(asset: SharedAsset.pride6),
                       Color(asset: SharedAsset.pride7),
                       Color(asset: SharedAsset.pride8)]

    init(progress: CGFloat,
         total: CGFloat = 5,
         fillColor: Color,
         backgroundColor: Color = Color(asset: SharedAsset.fieldBackground)) {
        self.progress = progress
        self.total = total
        self.fillColor = fillColor
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        GeometryReader { reader in
            progress(withColors: progress >= total ? prideColors : [fillColor])
                .cornerRadius(2)
                .frame(width: (progress / total) * reader.size.width,
                       alignment: .leading)
        }
        .background(Capsule()
            .foregroundColor(backgroundColor))
        .frame(height: 4)
    }

    func progress(withColors colors: [Color]) -> some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .fill(color)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }
}

struct PrideProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(0..<6) { value in
                ProgressBarView(progress: CGFloat(value), fillColor: Color.red)
            }
        }.padding().previewLayout(.sizeThatFits)
    }
}
