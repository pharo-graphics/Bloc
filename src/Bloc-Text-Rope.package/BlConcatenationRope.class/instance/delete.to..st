rope - deleting
delete: aStart to: anEnd
	self assertAccess: aStart.
	self assertAccess: anEnd.

	"We remove the whole left side, just return the right one"
	(aStart = 1 and: [ anEnd = left size ])
		ifTrue: [ ^ right ].
		
	"We remove the whole right side, just return the left one"
	(aStart = (left size + 1) and: [ anEnd = self size ])
		ifTrue: [ ^ left ].
	
	^ (aStart > 1 and: [ anEnd < self size ])
		ifTrue: [
			self class
				concatenate: (self from: 1 to: aStart - 1)
				and: (self from: anEnd + 1 to: self size) ]
		ifFalse: [
			(aStart <= 1 and: [ anEnd >= self size ])
				ifTrue: [ self empty ]
				ifFalse: [ aStart <= 1
					ifTrue: [ self from: anEnd + 1 to: self size ]
					ifFalse: [ self from: 1 to: aStart - 1 ] ] ]