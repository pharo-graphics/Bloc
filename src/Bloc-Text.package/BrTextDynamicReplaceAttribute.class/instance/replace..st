accessing
replace: aBrText
	| anObject |
	
	anObject := self object value.
	
	^ (self append and: [ self wantsNewSegment not ])
		ifTrue: [ { aBrText . anObject } ]
		ifFalse: [ anObject ]