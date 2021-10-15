Extension { #name : #BlDevScripterNestedChildEventTarget }

{ #category : #'*Bloc-Extensions' }
BlDevScripterNestedChildEventTarget >> gtTargetsFor: aView [
	<gtView>
	self targets ifNil: [ ^ aView empty ].
	^ (self targets gtItemsFor: aView)
		title: 'Targets'
]
