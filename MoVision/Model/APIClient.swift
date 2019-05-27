//
//  APIClient.swift
//  MoVision
//
//  Created by SDK on 5/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Alamofire

class APIClient {
    
    class func getMovies(_ categoryType: CategoryType, completion: @escaping (Movies?, Error?) -> Void) {
        let mainUrl: String
        let urlQueryParams = "&language=en-US&page=1"
        
        switch categoryType {
        case .topRated:
            mainUrl = Endpoints.topRatedMovies.stringValue
        case .upComing:
            mainUrl = Endpoints.upComingMovies.stringValue
        case .nowPlaying:
            mainUrl = Endpoints.nowPlayingMovies.stringValue
        }
        
        AF.request(mainUrl + urlQueryParams).responseDecodable { (response: DataResponse<Movies>) in
            
            switch response.result {
            case .success(var movies):
                movies.results = movies.results.map{ (movie: Movie) -> Movie in
                    var m = movie
                    if let posterPath = movie.posterPath {
                        m.posterPath = "https://image.tmdb.org/t/p/w185/" + posterPath
                    }
                    return m
                }
                
                completion(movies, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    class func getTVShows(_ categoryType: CategoryType, completion: @escaping (TVShows?, Error?) -> Void) {
        let mainUrl: String
        let urlQueryParams = "&language=en-US&page=1"
        
        switch categoryType {
        case .topRated:
            mainUrl = Endpoints.topRatedTVShows.stringValue
        case .upComing:
            mainUrl = Endpoints.upComingTVShows.stringValue
        case .nowPlaying:
            mainUrl = Endpoints.nowPlayingTVShows.stringValue
        }
        
        print(mainUrl + urlQueryParams)
        
        AF.request(mainUrl + urlQueryParams).responseDecodable { (response: DataResponse<TVShows>) in
            
            switch response.result {
            case .success(var tvShows):
                tvShows.results = tvShows.results.map{ (tvShow: TVShow) -> TVShow in
                    var t = tvShow
                    if let posterPath = tvShow.posterPath{
                        t.posterPath = "https://image.tmdb.org/t/p/w185/" + posterPath
                    }
                    return t
                }

                completion(tvShows, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
