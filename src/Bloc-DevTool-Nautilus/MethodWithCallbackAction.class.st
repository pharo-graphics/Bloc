"
I am a Nautilus plugin that marks method that define callback pragma
"
Class {
	#name : #MethodWithCallbackAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodWithCallbackAction >> actionOrder [
	"Return the priority of this action"
	
	^ 300
]

{ #category : #accessing }
MethodWithCallbackAction >> callbackOrNil [
	(method hasPragmaNamed: #callback:)
		ifFalse: [ ^ nil ].
	
	^ method methodClass classAndMethodFor: ((method pragmaAt: #callback:) argumentAt: 1)
		do: [ :aClass :aMethod | aMethod ]
		ifAbsent: [ nil ]
]

{ #category : #testing }
MethodWithCallbackAction >> isActionHandled [	
	^ self callbackOrNil isNotNil
]

{ #category : #order }
MethodWithCallbackAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
			
	anIcon := (self iconNamed: #class) collectColors: [ :each | 
		(each mixed: 0.5 with: Color magenta muchDarker) paler lighter lighter lighter  alpha: each alpha ].

	^ IconicButton new 
		target: self callbackOrNil;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Callback';
		borderWidth: 0
]
