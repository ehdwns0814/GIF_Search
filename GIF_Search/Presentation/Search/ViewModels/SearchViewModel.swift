//
//  SearchViewModel.swift
//  GIF_Search
//
//  Created by 동준 on 5/27/24.
//

import Foundation

final class SearchViewModel {
    typealias T = ImageObjectViewModel
    
    var gifURLStorage: Observable<[T]> = Observable([])
    
    private let giphyService: GiphyService
    
    private var hasNextPage: Bool?
    private var currentOffset: Int?
    private var searchType: MediaType = .gif
    private var searchQuery: String?
    
    
    // MARK: - Initializer(s)
    
    init(giphyService: GiphyService) {
        self.giphyService = giphyService
    }
    
    // MARK: - Method(s)
    
    func searchedFor(text: String) {
        self.searchQuery = text
    }
    
    private func searchGif(type: MediaType, query: String, offset: Int = 0) {
        self.giphyService.searchGif(
            type: type,
            query: query,
            offset: offset) { [weak self] result in
                switch result {
                case .success(let gifBundle):
                    self?.hasNextPage = gifBundle.hasNextPage
                    self?.currentOffset = gifBundle.offset + 10
                    self?.gifURLStorage.value? += gifBundle.gifs.map { ImageObjectViewModel(image: $0) }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
