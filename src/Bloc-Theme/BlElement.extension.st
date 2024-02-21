Extension { #name : #BlElement }

{ #category : #'*Bloc-Theme' }
BlElement >> theme [

	self deprecated: 'To be removed'.

	^ self userData
		at: #BlTheme
		ifAbsent: [ self hasParent
				ifTrue: [ self parent theme ]
				ifFalse: [ BlTheme default ] ]
]

{ #category : #'*Bloc-Theme' }
BlElement >> theme: aTheme [

	self deprecated: 'To be removed'.

	self userData at: #BlTheme put: aTheme.
	self properties
		addProperty:
			(BlThemeElementProperty new
				theme: aTheme;
				yourself)
]
