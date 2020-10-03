//
//  ControlFlowAPI.swift
//  ControlFlowApp
//
//  Created by Keran Marinov on 02/10/2020.
//  Copyright © 2020 KM LTD. All rights reserved.
//


/// Global function that returns Some type with the parameterized T

func when<Value>(_ value: Value) -> Some<Value> {
    Some(input: value)
}

func when<Case>(_ initialCase: Case) -> SomeCaseInitial<Case> {
    SomeCaseInitial<Case>(initialCase: initialCase)
}
