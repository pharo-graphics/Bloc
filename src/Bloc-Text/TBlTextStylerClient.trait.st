Trait {
	#name : #TBlTextStylerClient,
	#instVars : [
		'styler'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> classOrMetaClass: aClass [

	self stylerDo: [ :s | s classOrMetaClass: aClass ]
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> isForWorkspace: aBoolean [

	self stylerDo: [ :s | s isForWorkspace: aBoolean ]
]

{ #category : #'api - text style' }
TBlTextStylerClient >> launchStyle: aBlText in: anElement [

	self styler launchStyle: aBlText in: anElement
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> releaseStyler [

	self stylerDo: [ :st | 
		self terminateStyler.
		self styler unsubscribe: self ]
]

{ #category : #'api - styler hook' }
TBlTextStylerClient >> requestTextStyle [

	self explicitRequirement 
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> styler [

	^ styler
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> styler: aStyler [

	styler = aStyler ifTrue: [ ^ self ].
	self releaseStyler.
	styler := aStyler.
	self styler ifNotNil: [ 
		self styler when: BlStylerTextStyled send: #whenTextStyled: to: self.
		self styler when: BlStylerStateChanged send: #whenStylerStateChanged: to: self ].
	self announce: (BlStylerChanged new styler: self styler).
	self requestTextStyle 
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> stylerDo: aBlock [

	styler ifNotNil: aBlock
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> terminateStyler [
	self stylerDo: [ :st | st launcher terminateBackgroundStylingProcess ]
]

{ #category : #'api - styler hook' }
TBlTextStylerClient >> whenStylerStateChanged: aBlStylerStateChangedAnnouncement [

	"the internal configuration of the styler has changed"

	self requestTextStyle
]

{ #category : #'api - styler hook' }
TBlTextStylerClient >> whenTextStyled: aBlStylerTextStyleAnnouncement [

	self explicitRequirement 
]

{ #category : #'api - styler accessing' }
TBlTextStylerClient >> workspace: aWorkspace [

	self stylerDo: [ :s | s workspace: aWorkspace ]
]
