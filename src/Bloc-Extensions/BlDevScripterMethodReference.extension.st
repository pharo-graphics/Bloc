Extension { #name : #BlDevScripterMethodReference }

{ #category : #'*Bloc-Extensions' }
BlDevScripterMethodReference >> gtReferenceFor: aView [
	<gtView>
	self definition ifNil: [ ^ aView empty ].
	^ self definition gtSourceFor: aView
]
