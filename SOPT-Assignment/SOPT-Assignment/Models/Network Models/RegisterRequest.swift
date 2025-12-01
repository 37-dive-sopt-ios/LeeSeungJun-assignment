//
//  RegisterRequest.swift
//  sopt-37th-01Seminar
//
//  Created by 이승준 on 11/10/25.
//

/// 유저 등록 API
public struct RegisterRequest: Encodable {
    let username: String
    let password: String
    let name: String
    let email: String
    let age: Int
}

/// HTTP 메서드 (Moya의 Method와 동일!)
public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

/// 서버 파트장이 준 API 의 공통 응답 형식
/// 보통 BaseResponse 라고 합니다.
public struct BaseResponse<T: Decodable>: Decodable {
    public let success: Bool
    public let code: String?
    public let message: String?
    public let data: T?
}

/// 응답 데이터가 필요 없는 경우가 있을 거란 말이죠? 그걸 위한 Empty 타입입니다.
public struct EmptyResponse: Decodable {
    public init() {}
}
