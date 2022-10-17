Trait {
	#name : #TBlTextStylerClient,
	#instVars : [
		'styler'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'api - text style' }
TBlTextStylerClient >> launchStyle: aBlText in: anElement [

	self styler launchStyle: aBlText in: anElement
]

{ #category : #'api - accessing' }
TBlTextStylerClient >> requestTextStyle [

	self explicitRequirement 
]

{ #category : #'api - accessing' }
TBlTextStylerClient >> styler [

	^ styler
]

{ #category : #'api - accessing' }
TBlTextStylerClient >> styler: aStyler [

	styler = aStyler ifTrue: [ ^ self ].
	self styler ifNotNil: [ self styler unsubscribe: self ].
	styler := aStyler.
	self styler ifNotNil: [ 
		self styler when: BlStylerTextStyled send: #whenTextStyled: to: self.
		self styler when: BlStylerStateChanged send: #whenStylerStateChanged: to: self ].
	self announce: (BlStylerChanged new styler: self styler).
	self requestTextStyle
]

{ #category : #'api - text style' }
TBlTextStylerClient >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	self explicitRequirement 
]

{ #category : #'api - text style' }
TBlTextStylerClient >> whenTextStyled: aBlStylerTextStyleAnnouncement [

	self explicitRequirement 
]
