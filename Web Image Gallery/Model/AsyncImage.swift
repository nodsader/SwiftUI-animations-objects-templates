//
//  AsyncImage.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 23/06/2023.
//

import SwiftUI
import Combine

//This view allows SwiftUI to download an image from a URL and then use it in the gallery

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    
    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else if loader.loadingFailed {
            Image("not-found")  // Fallback image in case of an error
        } else {
            ProgressView()
        }
    }
}
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var loadingFailed = false

    private var cancellable: AnyCancellable?
    
    static let cacheConfig = URLSessionConfiguration.default
    static let urlSession = URLSession(configuration: cacheConfig)

    init(url: URL) {
        cancellable = Self.urlSession.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if $0 == nil {
                    self?.loadingFailed = true
                } else {
                    self?.image = $0
                }
            }
    }
    
    //We initialize a rather basic cache but which is the default one on SwiftUI
    
    init() {
        Self.cacheConfig.urlCache = URLCache(memoryCapacity: 500_000_000, diskCapacity: 1_000_000_000, diskPath: nil)
    }
}

