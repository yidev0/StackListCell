//
//  StackListCell.swift
//
//  Created by Yuto Iwakami
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct StackListCell<Icon: View, Title: View, Detail: View>: View {
    
    enum SLStackStyle {
        case horizontal, vertical
    }
    
    enum SLIconStyle {
        case icon, filled
    }
    
    var stackStyle: SLStackStyle
    var iconStyle: SLIconStyle
    
    var title: Title
    var detail: Detail?
    var image: Icon
    
    init(
        _ stackStyle: SLStackStyle = .horizontal,
        iconStyle: SLIconStyle = .filled,
        @ViewBuilder title: () -> Title,
        @ViewBuilder detail: () -> Detail,
        @ViewBuilder image: () -> Icon
    ) {
        self.stackStyle = stackStyle
        self.iconStyle = iconStyle
        self.image = image()
        self.title = title()
        self.detail = detail()
    }
    
    @Environment(\.dynamicTypeSize) var dynamicType
    #if os(macOS)
    @State var fontSize = NSFont.preferredFont(forTextStyle: .body).pointSize
    #else
    @State var fontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
    #endif
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(TintShapeStyle())
                    .frame(width: fontSize + 16, height: fontSize + 16)
                
                image
                    .foregroundColor(.white)
                    .font(.body)
            }
            .padding(.vertical, 1)
            
            switch stackStyle {
            case .vertical:
                VStack(alignment: .leading, spacing: 0) {
                    title
                        .foregroundColor(.primary)
                    
                    if let detail = detail {
                        detail
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            case .horizontal:
                HStack(alignment: .center, spacing: 2) {
                    title
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if let detail = detail {
                        detail
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
        }
        .onChange(of: dynamicType) { newValue in
            #if os(macOS)
            fontSize = NSFont.preferredFont(forTextStyle: .body).pointSize
            #else
            fontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
            #endif
        }
    }
}

extension StackListCell where Icon == Image, Title == Text, Detail == Text {
    init(
        _ stackStyle: SLStackStyle = .horizontal,
        iconStyle: SLIconStyle = .filled,
        title: LocalizedStringKey,
        detail: LocalizedStringKey? = nil,
        systemImage: String
    ) {
        self.stackStyle = stackStyle
        self.iconStyle = iconStyle
        self.image = Image(systemName: systemImage)
        self.title = Text(title)
        if let detail = detail {
            self.detail = Text(detail)
        }
    }
    
    init(
        _ stackStyle: SLStackStyle = .horizontal,
        iconStyle: SLIconStyle = .filled,
        title: LocalizedStringKey,
        detail: LocalizedStringKey? = nil,
        imageName: String
    ) {
        self.stackStyle = stackStyle
        self.iconStyle = iconStyle
        self.image = Image(imageName)
        self.title = Text(title)
        if let detail = detail {
            self.detail = Text(detail)
        }
    }
}
