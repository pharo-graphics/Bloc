"
I am a Nautilus plugin that marks method that define event pragma
"
Class {
	#name : #MethodWithEventAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodWithEventAction >> actionOrder [
	^ 200
]

{ #category : #actions }
MethodWithEventAction >> browseEvents [
	| theEvents |
	
	theEvents := self events.
	
	theEvents ifEmpty: [ ^ self ].

	theEvents size = 1
		ifTrue: [ ^ theEvents first browse ].

	Smalltalk tools browser
		openOnGroup: (NautilusClassGroup named: 'Events' classes: theEvents) beReadOnly
		inEnvironment: (RBClassEnvironment classes: theEvents)
]

{ #category : #accessing }
MethodWithEventAction >> events [
	(method hasPragmaNamed: #event:)
		ifFalse: [ ^ #() ].
	
	^ (method pragmas select: [ :aPragma | aPragma keyword = #event: ])
		flatCollect: [ :aPragma |
			self class environment
				at: (aPragma argumentAt: 1)
				ifPresent: [ :aClass | { aClass } ]
				ifAbsent: [ #() ] ]
]

{ #category : #testing }
MethodWithEventAction >> isActionHandled [	
	^ self events isNotEmpty
]

{ #category : #order }
MethodWithEventAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
			
	anIcon := (self iconNamed: #announcement).

	^ IconicButton new 
		target: self;
		actionSelector: #browseEvents;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Browse event (scoped)';
		borderWidth: 0
]
