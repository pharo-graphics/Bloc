Extension { #name : #Character }

{ #category : #'*Bloc' }
Character >> isLineBreak [

	^ self = self class cr or: [
		  self = self class lf or: [ self = self class nel ] ]
]

{ #category : #'*Bloc' }
Character >> isPureSeparator [

	self deprecated: 'To be removed'.

	^ self isSeparator and: [ self isLineBreak not ]
]
