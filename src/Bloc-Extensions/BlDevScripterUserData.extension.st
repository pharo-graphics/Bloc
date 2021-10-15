Extension { #name : #BlDevScripterUserData }

{ #category : #'*Bloc-Extensions' }
BlDevScripterUserData >> gtUserDataFor: aView [
	<gtView>
	dictionary ifNil: [ ^ aView empty ].
	^ (dictionary gtItemsFor: aView)
		title: 'User Data'
]
