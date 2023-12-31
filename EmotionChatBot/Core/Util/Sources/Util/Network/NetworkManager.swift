//
//  NetworkManager.swift
//  
//
//  Created by kimchansoo on 2023/11/26.
//

import Foundation

import Alamofire
import RxSwift

public final class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIEventLogger()
        return Session(configuration: configuration, eventMonitors: [apiLogger])
    }()
    
    private let headers: HTTPHeaders = [
        "accept": "application/json",
        "Content-Type": "application/json"
    ]
    
    private init() {}
    
    public func request<T: Decodable>(url: URLConvertible,
                                 method: HTTPMethod = .get,
                                 parameters: Parameters? = nil,
                                 encoding: ParameterEncoding = JSONEncoding.default,
                                 headers: HTTPHeaders? = nil,
                                 interceptor: RequestInterceptor? = nil,
                                 requestModifier: Session.RequestModifier? = nil,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        session.request(url,
                 method: method,
                 parameters: parameters,
                 encoding: encoding,
                 headers: headers,
                 interceptor: interceptor,
                 requestModifier: requestModifier)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
            completion(.success(value))
            case .failure(let error):
            completion(.failure(error))
            }
        }
    }
    
    // Observable로 반환
    public func request<T: Decodable>(url: URLConvertible,
                                 method: HTTPMethod = .get,
                                 parameters: Parameters? = nil,
                                 encoding: ParameterEncoding = URLEncoding.default,
                                 headers: HTTPHeaders? = nil,
                                 interceptor: RequestInterceptor? = nil,
                                 requestModifier: Session.RequestModifier? = nil) -> Observable<T> {
        return Observable.create { [unowned self] observer in
            self.session.request(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headers,
                     interceptor: interceptor,
                     requestModifier: requestModifier)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                observer.onNext(value)
                observer.onCompleted()
                case .failure(let error):
                observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}
