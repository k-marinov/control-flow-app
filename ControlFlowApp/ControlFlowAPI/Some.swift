//
//  Some.swift
//  ControlFlowApp
//
//  Created by Keran Marinov on 02/10/2020.
//  Copyright © 2020 KM LTD. All rights reserved.
//

struct SomeCaseInitial<Case> {

    fileprivate let initialCase: Case
    private let isTerminated: Bool

    init(initialCase: Case, isTerminated: Bool = false) {
        self.initialCase = initialCase
        self.isTerminated = isTerminated
    }

}

struct SomeCaseNext<Case, Return> {

    fileprivate let `case`: Case
    fileprivate let returnValue: Return
    private let isTerminated: Bool

    init(case: Case, returnValue: Return, isTerminated: Bool = false) {
        self.case = `case`
        self.returnValue = returnValue
        self.isTerminated = isTerminated
    }

    /// Returns the value of the closure return,
    /// if it is not terminated by the then method which sets the isTerminated bool to true.
    func `else`(_ value: () -> Return) -> Return {
        guard !isTerminated else { return returnValue }
        return value()
    }

}


struct Some<Input> {

    fileprivate let input: Input
    private let isTerminated: Bool


    init(input: Input, isTerminated: Bool = false) {
        self.input = input
        self.isTerminated = isTerminated
    }

    /// when false executes the closure
    func `else`(_ execute: () -> Void) {
        guard !isTerminated else { return }
        execute()
    }

    /// Returns the value of the closure return,
    /// if it is not terminated by the then method which sets the isTerminated bool to true.
    func `else`<Value>(_ value: Value) -> Value {
        guard !isTerminated else { return value }
        return value
    }

}


extension Some where Input == Bool {

    /// When true executes the closure
    @discardableResult
    func then( _ execute: () -> Void) -> Self {
        guard input else { return self }
        execute()
        return Some(input: input, isTerminated: true)
    }

    /// When the input is true returns the value of the closure return.
    @discardableResult
    func then<Value>( _ value: Value) -> Some<Value> {
        guard input else {
            return Some<Value>(input: value, isTerminated: false)
        }
        return Some<Value>(input: value, isTerminated: true)
    }

}

extension SomeCaseNext where Case: Equatable {

    /// When the input is true returns the value of the closure return.
    @discardableResult
    func `case`(_ inputCase: Case, _ value: () -> Return) -> Self {
        guard `case` == inputCase, !isTerminated else {
            return self
        }
        return SomeCaseNext<Case, Return>(case: `case`, returnValue: value(), isTerminated: true)
    }

}


extension SomeCaseInitial where Case: Equatable {

    /// When the input is true returns the value of the closure return.
    @discardableResult
    func `case`<Value>(_ inputCase: Case, _ value: () -> Value) -> SomeCaseNext<Case, Value> {
        guard initialCase == inputCase else {
            return SomeCaseNext(case: initialCase, returnValue: value(), isTerminated: isTerminated)
        }
        return SomeCaseNext(case: inputCase, returnValue: value(), isTerminated: true)
    }

}

extension Some where Input: Comparable {

    @discardableResult
    func `in`(_ range: ClosedRange<Input>, _ execute: () -> Void) -> Some<Input> {
        guard range.contains(input) else { return self }
        execute()
        return Some(input: input)
    }

    @discardableResult
    func `in`(_ range: Range<Input>, _ execute: () -> Void) -> Some<Input> {
        guard range.contains(input) else { return self }
        execute()
        return Some(input: input)
    }

    @discardableResult
    func not(in range: ClosedRange<Input>, _ execute: () -> Void) -> Some<Input> {
        guard !range.contains(input) else { return self }
        execute()
        return Some(input: input)
    }

    @discardableResult
    func not(in range: Range<Input>, _ execute: () -> Void) -> Some<Input> {
        guard !range.contains(input) else { return self }
        execute()
        return Some(input: input)
    }

    @discardableResult
    func found(in values: [Input], _ execute: () -> Void) -> Some<Input> {
        guard values.contains(input) else { return self }
        execute()
        return Some(input: input)
    }

    @discardableResult
    func greater(than inputValue: Input, _ execute: () -> Void) -> Some<Input> {
        return compare(>, inputValue, execute)
    }

    @discardableResult
    func greaterThan(orEqual inputValue: Input, _ execute: () -> Void) -> Some<Input> {
        return compare(>=, inputValue, execute)
    }

    @discardableResult
    func lowerThan(orEqual inputValue: Input, _ execute: () -> Void) -> Some<Input> {
        return compare(<=, inputValue, execute)
    }

    @discardableResult
    func lower(than inputValue: Input, _ execute: () -> Void) -> Some<Input> {
        return compare(<, inputValue, execute)
    }

    @discardableResult
    func equal(to inputValue: Input, _ execute: () -> Void) -> Some<Input> {
        return compare(==, inputValue, execute)
    }

    /// Helper method for comparison
    @discardableResult
    private func compare(
        _ comparator: (Input, Input) -> Bool,
        _ inputValue: Input,
        _ execute: () -> Void
    ) -> Some<Input> {
        guard comparator(input, inputValue) else { return self }
        execute()
        return Some(input: input, isTerminated: true)
    }

}
