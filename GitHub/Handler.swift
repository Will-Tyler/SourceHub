//
//  Handler.swift
//  EssentialsTests
//
//  Created by Will Tyler on 4/2/19.
//

import Foundation


/// Handler is a class that takes in a closure and checks that
/// the closure is executed exactly once using assert calls.
@dynamicCallable
public class Handler<T, E: Error> {

	private let closure: (Result<T, E>)->()
	private var didExecute = false
	private let semaphore = DispatchSemaphore(value: 1)

	public init(_ closure: @escaping (Result<T, E>)->()) {
		self.closure = closure
	}

	deinit {
		assert(didExecute)
	}

	public func execute(with result: Result<T, E>) {
		semaphore.wait()
		assert(!didExecute)

		if !didExecute {
			closure(result)
		}

		didExecute = true
		semaphore.signal()
	}

	func dynamicallyCall(withArguments arguments: [Result<T, E>]) {
		assert(arguments.count == 1)

		if let first = arguments.first {
			execute(with: first)
		}
	}

}
