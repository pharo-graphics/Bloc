Extension { #name : #BlDevScripterStep }

{ #category : #'*Bloc-Extensions' }
BlDevScripterStep >> gtReferenceFor: aView [
	<gtView>
	self reference ifNil: [ ^ aView empty ].
	^ (self reference gtReferenceFor: aView)
		priority: 5
]

{ #category : #'*Bloc-Extensions' }
BlDevScripterStep >> gtScreenshotFor: aView [
	<gtView>
	self properties ifNil: [ ^ aView empty ].
	^ self properties gtScreenshotFor: aView
]
