Extension { #name : #Form }

{ #category : #'*Bloc' }
Form >> asBlBackground [
	^ BlBackground image: self
]

{ #category : #'*Bloc' }
Form >> asElement [
	^ BlElement new
		size: self extent;
		background: self;
		yourself
]

{ #category : #'*Bloc' }
Form >> asForm [
	^ self
]
