//
//  SettingsPreviewContainer.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import SwiftData
import SwiftUI

struct BlankSettingsSampleData: PreviewModifier {
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(
            for: INRRecorderSettings.self,
            configurations: .init(isStoredInMemoryOnly: true)
        )
        container.mainContext.insert(INRRecorderSettings.blankSettings)
        return container
    }
    func body(content: Content, context: ModelContainer) -> some View {
            content.modelContainer(context)
        }
}
extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var blankSettingsSampleData: Self = .modifier(BlankSettingsSampleData())
}
