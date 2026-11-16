Extension { #name : #Form }

{ #category : #'*Bloc' }
Form >> asBlBackground [
	^ BlBackground image: self
]

{ #category : #'*Bloc' }
Form >> asElement [
	^ BlElement new
		extent: self extent;
		background: self;
		yourself
]

{ #category : #'*Bloc' }
Form >> asForm [
	^ self
]
