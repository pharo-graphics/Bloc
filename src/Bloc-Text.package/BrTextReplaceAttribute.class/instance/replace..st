accessing
replace: aBrText
	| string |
	
	string := self text asString.
	
	^ ((aBrText copy insertString: string at: 0) from: 1 to: string size)
		attributes: self attributes