//
//  ConditionalOnboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This onboarding takes a conditional block, that must return
 `true` for `shouldBePresented` to return true.
 
 Other than that, it behaves just like the `Onboarding` base
 class and will only be presented once.
 */
open class ConditionalOnboarding: Onboarding {
    
    /**
     Create a delayed onboarding experience.
     
     - Parameters:
        - id: The unique onboarding id.
        - userId: An optional user id.
        - defaults: The `UserDefaults` instance to use.
        - condition: A condition that must return `true` for `shouldBePresented` to become `true`.
     */
    public init(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard,
        condition: @escaping Condition) {
        self.condition = condition
        super.init(id: id, userId: userId, defaults: defaults)
    }
    
    
    public typealias Condition = () -> Bool
    
    private let condition: Condition
    
    
    /**
     Whether or not the onboarding should be presented.
     */
    open override var shouldBePresented: Bool {
        condition() && super.shouldBePresented
    }
}
