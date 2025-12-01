//
//  LoginViewModel_1.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 12/1/25.
//

import Combine

final class LoginViewModel {
    
    // MARK: Properties

    var id = PassthroughSubject<String, Never>()
    var password = PassthroughSubject<String, Never>() // combineLatest를 쓰기 위해서는 Publisher를 따르는 타입이어야 한다.
    @Published var isLoginEnabled: AnyPublisher<Bool, Never>
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: initializer
    
    init() {
        isLoginEnabled = id
            .combineLatest(password) { id, password in
                return !id.isEmpty && !password.isEmpty
            }
            .eraseToAnyPublisher()
    }

}
