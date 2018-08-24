Extension { #name : #Number }

{ #category : #'*Bloc-Style' }
Number >> asBlEm [
	^ BlStyleValue em: self
]

{ #category : #'*Bloc-Style' }
Number >> asBlMs [
	^ BlStyleValue ms: self
]

{ #category : #'*Bloc-Style' }
Number >> asBlSec [
	^ BlStyleValue s: self
]

{ #category : #'*Bloc-Style' }
Number >> asBlStyleValue [
	^ BlNumberValue value: self
]

{ #category : #'*Bloc-Style' }
Number >> em [
	^ self
]

{ #category : #'*Bloc-Style' }
Number >> ms [
	^ self 
]

{ #category : #'*Bloc-Style' }
Number >> rem [
	^ self
]

{ #category : #'*Bloc-Style' }
Number >> s [
	^ self * 1000
]
