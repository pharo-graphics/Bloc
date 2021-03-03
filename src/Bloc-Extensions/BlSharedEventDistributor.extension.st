Extension { #name : #BlSharedEventDistributor }

{ #category : #'*Bloc-Extensions' }
BlSharedEventDistributor >> gtRegisteredElementsFor: aView [
	<gtView>
	elements ifNil: [ ^ aView empty ].
	elements ifEmpty: [ ^ aView empty ].
	^ (elements gtItemsFor: aView)
		title: 'Registered Elements'
]
