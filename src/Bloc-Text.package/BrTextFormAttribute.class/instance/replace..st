accessing
replace: aBrText
	| aForm |
	
	aForm := self formBlock cull: aBrText.
	
	^ (self append and: [ self wantsNewSegment not ])
		ifTrue: [ { aBrText . aForm } ]
		ifFalse: [ aForm ]