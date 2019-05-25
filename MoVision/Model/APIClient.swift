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
                    m.posterPath = "https://image.tmdb.org/t/p/w185/" + movie.posterPath
                    return m
                }
                
                completion(movies, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
