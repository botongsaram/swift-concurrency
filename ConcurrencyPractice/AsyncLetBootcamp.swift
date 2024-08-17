//
//  AsyncLetBootcamp.swift
//  CountdownRobin
//
//  Created by Seung Eun Lee on 8/16/24.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url =  URL(string: "https://picsum.photos/200")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let!")
            .onAppear {
                
                
                Task {
                    do {
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
//                        async let fetchTitle = fetchTitle()
//                        
//                        let (image1, image2, title) = await (try fetchImage1, try fetchImage2, try fetchTitle)
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        async let fetchImage5 = fetchImage()
                        
                        let (image1, image2, image3, image4, image5) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4, try fetchImage5)
                        self.images.append(contentsOf: [image1, image2, image3, image4, image5])
                        
//                        let imag1 = try await fetchImage()
//                        self.images.append(imag1)
//                        let imag2 = try await fetchImage()
//                        self.images.append(imag2)
//                        let imag3 = try await fetchImage()
//                        self.images.append(imag3)
//                        let imag4 = try await fetchImage()
//                        self.images.append(imag4)
//                        let imag5 = try await fetchImage()
//                        self.images.append(imag5)
                    }
                    catch {
                        
                    }
                }
                self.images.append(UIImage(systemName: "heart.fill")!)
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
        do {
            let (data, _) = try await URLSession.shared.data(from:  url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    func fetchTitle() async -> String {
        return "New Title"
    }
}

#Preview {
    AsyncLetBootcamp()
}
