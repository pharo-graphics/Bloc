Trait {
	#name : 'TBlDirectionalLayout',
	#instVars : [
		'direction'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : 'api - direction' }
TBlDirectionalLayout >> direction [
	^ direction ifNil: [ self defaultDirection ]
]

{ #category : 'api - direction' }
TBlDirectionalLayout >> direction: aBlLayoutDirection [
	direction := aBlLayoutDirection
]

{ #category : 'api - direction' }
TBlDirectionalLayout >> leftToRight [
	direction := BlLayoutDirection leftToRight
]

{ #category : 'api - direction' }
TBlDirectionalLayout >> rightToLeft [
	direction := BlLayoutDirection rightToLeft
]
