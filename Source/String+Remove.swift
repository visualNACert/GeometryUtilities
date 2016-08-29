//
//  String+Remove.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 11/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

extension String {

	/**
	 Returns resulting stirng of removing occurrences of given string from this
	 string.

	 - parameter target: String to be removed from this string.

	 - returns: Resulting string.
	 */
	func stringByRemoving(target: String) -> String {
		return self.stringByReplacingOccurrencesOfString(target, withString: "")
	}

	/**
	 Returns resulting stirng of removing occurrences of given strings from this
	 string.

	 - parameter targets: Strings to be removed from this string.

	 - returns: Resulting string.
	 */
	func stringByRemoving(targets: [String]) -> String {
		return targets.reduce(self) { $0.stringByRemoving($1) }
	}

}
