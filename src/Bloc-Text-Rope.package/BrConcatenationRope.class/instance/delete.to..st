rope - deleting
delete: aStart to: anEnd
	| newLeft newRight |
	self assertAccess: aStart.
	self assertAccess: anEnd.

	"We remove the whole left side, just return the right one"
	(aStart = 1 and: [ anEnd = left size ])
		ifTrue: [ ^ right ].
		
	"We remove the whole right side, just return the left one"
	(aStart = (left size + 1) and: [ anEnd = self size ])
		ifTrue: [ ^ left ].
		
	newLeft := self from: 1 to: aStart - 1.
	newRight := self from: anEnd + 1 to: self size.
	
	^ self class
		concatenate: newLeft
		and: newRight