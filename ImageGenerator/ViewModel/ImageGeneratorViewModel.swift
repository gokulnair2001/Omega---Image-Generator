//
//  ImageGeneratorViewModel.swift
//  ImageGenerator
//
//  Created by Gokul Nair on 15/12/22.
//

import OpenAIKit
import SwiftUI

final class ImageGeneratorViewModel: ObservableObject {
    
    private var openAI: OpenAI?
    
    func setup() {
        openAI = OpenAI(Configuration(
            organization: Keys.shared.orgID,
            apiKey: Keys.shared.apiKey))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openAI else { return nil }
        
        do {
            
            let params = ImageParameters(prompt: prompt, resolution: .medium, responseFormat: .base64Json, user: UUID().uuidString)
            
            let result = try await openai.createImage(parameters: params)
            
            let image = result.data[0].image
            
            let finalImage = try openai.decodeBase64Image(image)
            
            return finalImage
            
        }catch {
            return nil
        }
    }
}
