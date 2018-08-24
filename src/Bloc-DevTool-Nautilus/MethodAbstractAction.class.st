"
I am a Nautilus plugin that marks abstract method (self subclassResponsibility) with an #abstract icon
"
Class {
	#name : #MethodAbstractAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodAbstractAction >> actionOrder [
	"Return the priority of this action"
	
	^ 100
]

{ #category : #order }
MethodAbstractAction >> isActionHandled [	
	^ method isSubclassResponsibility
]

{ #category : #order }
MethodAbstractAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
	
	anIcon := self iconNamed: #abstract.

	^ IconicButton new 
			target: method;
			actionSelector: #browse;
			labelGraphic: anIcon;
			color: Color transparent;
			extent: self iconExtent;
			helpText: 'Browse the overriden trait';
			borderWidth: 0
]
