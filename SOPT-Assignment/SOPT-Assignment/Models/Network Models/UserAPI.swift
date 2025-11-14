//
//  UserAPI.swift
//  sopt-37th-01Seminar
//
//  Created by 이승준 on 11/10/25.
//

import Foundation

/// User 관련 API 엔드포인트
/// Moya의 TargetType 과 비슷하게 구현함
public enum UserAPI {
    case delete(Int)     // DELETE   /api/v1/users/id
    case get(Int)           // GET      /api/v1/users/id
    case register(RegisterRequest)          // POST     /api/v1/users - 회원가입
    case login(LoginRequest)                // POST     /api/v1/auth/login - 로그인
    case update(Int, UpdateUserRequest)     // PATCH    /api/v1/users/id
}

extension UserAPI: TargetType {

    /// 기본 URL
    public var baseURL: String {
        // SOPT 세미나 서버 URL (4주차 임시 개방)
        // TODO: 실제 배포 시에는 xcconfig 파일이나 환경 변수로 관리하세요
        return "http://15.164.129.239"
    }

    /// API 경로
    public var path: String {
        switch self {
        case .register:
            return "/api/v1/users"
        case .login:
            return "/api/v1/auth/login"
        case .delete(let id), .get(let id), .update(let id, _):
            return "/api/v1/users/\(id)"
        }
    }

    /// The HTTP method used in the request.
    public var method: Method {
        switch self {
        case .delete:
            return .delete
        case .get:
            return .get
        case .register:
            return .post
        case .login:
            return .post
        case .update:
            return .patch
        }
    }

    /// The type of HTTP task to be performed.
    public var task: HTTPTask {
        switch self {
        case .delete:
            return .requestPlain
            
        case .get:
            return .requestPlain
            
        case .register(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)
            
        case .login(let request):
            // JSON 인코딩 가능한 객체를 바디로 전송
            return .requestJSONEncodable(request)
            
        case .update(_, let request):
            return .requestJSONEncodable(request)
        }
    }

    /// 헤더 (Moya와 동일 - 필요시 오버라이드)
    public var headers: [String: String]? {
        // Content-Type은 Task에서 자동 설정되므로 여기서는 nil 반환
        return nil
    }
}

// MARK: - Convenience Methods

extension UserAPI {
    
    public static func performDeleteUser(
        id: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> Bool {
        let response: BaseResponse<EmptyResponse> = try await provider.request(UserAPI.delete(id))
        return response.success
    }
    
    public static func performGetUser(
        id: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.get(id))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    /// 회원가입 API 요청 헬퍼
    public static func performRegister(
        username: String,
        password: String,
        name: String,
        email: String,
        age: Int,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = RegisterRequest(
            username: username,
            password: password,
            name: name,
            email: email,
            age: age
        )
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.register(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }

    /// 로그인 API 요청 헬퍼
    public static func performLogin(
        username: String,
        password: String,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> LoginResponse {
        let request = LoginRequest(username: username, password: password)
        // BaseResponse로 감싸진 응답 디코딩
        let response: BaseResponse<LoginResponse> = try await provider.request(UserAPI.login(request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
    
    public static func performUpdateUser(
        id: Int,
        name: String?,
        email: String?,
        age: Int?,
        provider: NetworkProviding = NetworkProvider()
    ) async throws -> UserResponse {
        let request = UpdateUserRequest(name: name, email: email, age: age)
        let response: BaseResponse<UserResponse> = try await provider.request(UserAPI.update(id, request))
        guard let data = response.data else {
            throw NetworkError.noData
        }
        
        return data
    }
        
    
}
