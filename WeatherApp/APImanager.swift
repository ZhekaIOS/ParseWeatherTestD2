//
//  APImanager.swift
//  WeatherApp
//
//  Created by Евгений Ковалевский on 11.01.2018.
//  Copyright © 2018 Евгений Ковалевский. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONcomplitionHandler =  ([String: AnyObject]?, HTTPURLResponse? , Error?) -> Void

protocol JSONDecodable {
    init?(JSON: [String : AnyObject])
}

protocol FinalURLPoint  {
    var baseURL : URL {get}
    var path : String {get}
    var request : URLRequest {get}
    
}
enum APIresult <T> {
    case Success (T)
    case Failure (Error)
}

protocol APImanager {
    var sessionConfiguration : URLSessionConfiguration {get} //1 создать конфигурацию
    var session : URLSession {get} // идет сессия на основе конфигурации
    
    func JSONTaskWith( request : URLRequest , complitionHendler: @escaping  JSONcomplitionHandler ) -> JSONTask // 1 метод на получение данных
    func fetch <T : JSONDecodable>  ( request : URLRequest, parse : @escaping  ([String : AnyObject])-> T?, completionHandler : @escaping (APIresult<T>)-> Void ) // передаем запрос, который попадает внутрь метода и преобразовываем его в формат Т (карентвезер) написано Т , чтоб можно было в будущем его использовать в других проектах
    
}

extension APImanager {
    func JSONTaskWith( request : URLRequest , complitionHendler: @escaping JSONcomplitionHandler ) -> JSONTask  {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString( "Missing HTTP Response", comment: "")]
                let error = NSError(domain: SWINetworkingErrorDomain, code: 100, userInfo: userInfo)
                complitionHendler(nil, nil, error)
                return
            }
            if data == nil{
                if let error = error{
                    complitionHendler (nil, HTTPResponse , error)
                }
            } else {
                switch HTTPResponse.statusCode{
                case 200 : do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                    complitionHendler(json, HTTPResponse, nil)
                } catch let error as NSError {
                    complitionHendler(nil, HTTPResponse, error)
                    }
                default : print(" We have got status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    func fetch <T> ( request : URLRequest, parse : @escaping ([String : AnyObject])-> T?, completionHandler :  @escaping (APIresult<T>)-> Void ) {
        let dataTask = JSONTaskWith(request: request) { (json, response, error) in //если ошибка, то пишем ошибку
            DispatchQueue.main.async { //объявляю главный поток
                guard let json = json else {
                    if let error = error {
                        completionHandler(.Failure (error)) // тип определенный сверху
                    }
                    return
                }
                if let value = parse(json) { // если значение данных равно json, то идем дальше
                    completionHandler(.Success(value))
                } else { // если не получилось, то создаем ошибку
                    let error = NSError (domain: SWINetworkingErrorDomain, code: 200, userInfo: nil)
                    completionHandler(.Failure(error))
                }
            }
            
        }
        dataTask.resume()
    }
}


























