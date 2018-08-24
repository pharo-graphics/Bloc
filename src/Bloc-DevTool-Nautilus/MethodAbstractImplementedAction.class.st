"
I am a Nautilus plugin that marks abstract methods that are implemented in a subclass with green abstract icon
"
Class {
	#name : #MethodAbstractImplementedAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodAbstractImplementedAction >> actionOrder [
	"Return the priority of this action"
	
	^ 100
]

{ #category : #order }
MethodAbstractImplementedAction >> isActionHandled [	
	^ method methodClass allSuperclasses
		detect: [ :aClass | (aClass compiledMethodAt: method selector ifPresent: [ true ] ifAbsent: [ false]) and: [ (aClass >> method selector) isSubclassResponsibility ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #order }
MethodAbstractImplementedAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
			
	anIcon := ((self iconNamed: #abstract) collectColors: [ :each | 
		(Color r: each red * 0.40  g: each green b: each blue * 0.5 alpha: each alpha) twiceLighter slightlyLighter ]).

	^ IconicButton new 
		target: method;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Overrides abstract method';
		borderWidth: 0
]
