//
//  String+regex.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 6/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

extension String {

	/// Cache of regular expressions created.
	static var regexCache = [String: NSRegularExpression]()

	/**
	 Returns matches for given regex in this string.

	 - parameter pattern: Pattern to match in this string.

	 - throws: `NSError` if regex is malformed.

	 - returns: Matches for given regex in this string.
	 */
	func matchesForRegex(pattern: String) throws -> [String] {

		let regex: NSRegularExpression
		if let r = String.regexCache[pattern] {
			regex = r
		} else {
			regex = try NSRegularExpression(pattern: pattern, options: [.AnchorsMatchLines, .CaseInsensitive])
			String.regexCache[pattern] = regex
		}

		let nsString = self as NSString

		let results = regex.matchesInString(
			self,
			options: [],
			range: NSMakeRange(0, nsString.length)
		)

		return results.flatMap { result in
			(0..<result.numberOfRanges)
				.map { result.rangeAtIndex($0) }
				.map { nsString.substringWithRange($0) }
		}

	}

}