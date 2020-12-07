//
//  NetworkingClient.swift
//  TNU.STUDENTS
//
//  Created by mac on 1/29/20.
//  Copyright © 2020 Istiqlol Soft. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    
    typealias WebServiceResponseAuth = ([String: Any]?, Error?) -> Void
    typealias WebServiceResponseProfile = (StudentsInfo?, Error?) -> Void
    typealias WebServiceResponseSemesters = ([Semester]?, Error?) -> Void
    typealias WebServiceResponseCourses = ([Course]?, Error?) -> Void
    
    func auth(token: String, login: String , password: String, completion: @escaping WebServiceResponseAuth){
        
        guard let url = URL(string: "http://109.74.66.100:3389/api/v1/auth") else {
            return
        }
        
        let headers: HTTPHeaders = ["token": token]
        let parameters = ["login": login, "password": password]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers ).validate().responseJSON { response in
            
            if let error = response.error {
                
                if response.response != nil {
                    if response.response?.statusCode == 404 {
                        IncLoadData.inCorrectLogOrPass = true
                        print("ASDASdasd")
                    } 
                } else {
                    IncLoadData.serverNotResponse = true
                }
                
                completion(nil, error)
                
                
            } else if let jsonDict = response.value as? [String: Any] {
                print("EE")
                //let token = jsonDic["message"] as! String
                //print(token)
                completion(jsonDict, nil)
            }
        }
        
    }
    
    func getProfile(token: String, completion: @escaping WebServiceResponseProfile){
        
        guard let url = URL(string: "http://109.74.66.100:3389/api/v1/student/profile") else {
            return
        }
        
        let headers: HTTPHeaders = ["token": token]
        
        AF.request(url, method: .get, headers: headers ).validate().responseJSON { response in
            if let error = response.error {
                
                if response.response == nil {
                    IncLoadData.serverNotResponse = true
                }
            
                completion(nil, error)
            } else if let result = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let studentInfo = try jsonDecoder.decode(StudentsInfo.self, from: result)
                    completion(studentInfo, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        
        }
    }
    
    func getSemesters(token: String, completion: @escaping WebServiceResponseSemesters) {
        
        guard let url = URL(string: "http://109.74.66.100:3389/api/v1/student/academic_years") else {
            return
        }
        
        let headers: HTTPHeaders = ["token": token]
        
        AF.request(url, method: .get, headers: headers ).validate().responseJSON { response in
           
            
            if let error = response.error{
                if response.response == nil {
                    IncLoadData.serverNotResponse = true
                }
                completion(nil, error)
                print(error.localizedDescription)
            } else if let result = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    print(response.description)
                    let semesters = try jsonDecoder.decode([Semester].self, from: result)
                    completion(semesters, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getCoursesBySemester(token: String, semesterId: Int, completion: @escaping WebServiceResponseCourses){
        
        guard let url = URL(string: "http://109.74.66.100:3389/api/v1/student/grades/\(semesterId)") else {
            return
        }
        
        let headers: HTTPHeaders = ["token": token]
        
        AF.request(url, method: .get, headers: headers ).validate().responseJSON { response in
            print(response)
            if let error = response.error {
                if response.response == nil {
                    IncLoadData.serverNotResponse = true
                }
                completion(nil, error)
            } else if let result = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let courses = try jsonDecoder.decode([Course].self, from: result)
                    completion(courses, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
}
