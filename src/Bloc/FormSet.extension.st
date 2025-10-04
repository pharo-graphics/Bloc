Extension { #name : #FormSet }

{ #category : #'*Bloc' }
FormSet >> asBlBackground [

	^ BlBackground formSet: self
]

{ #category : #'*Bloc' }
FormSet >> asElement [

	^ BlElement new
		extent: self extent;
		background: self;
		yourself
]
