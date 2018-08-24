Extension { #name : #Integer }

{ #category : #'*Bloc-Style' }
Integer >> asBlPt [
	^ BlStyleValue pt: self
]

{ #category : #'*Bloc-Style' }
Integer >> asBlPx [
	^ BlStyleValue px: self
]

{ #category : #'*Bloc-Style' }
Integer >> pt [
	^self
]

{ #category : #'*Bloc-Style' }
Integer >> px [
	^self
]
