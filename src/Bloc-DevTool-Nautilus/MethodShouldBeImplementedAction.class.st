"
I am a Nautilus plugin that marks method tht should be implemented
"
Class {
	#name : #MethodShouldBeImplementedAction,
	#superclass : #AbstractMethodIconAction,
	#category : 'Bloc-DevTool-Nautilus'
}

{ #category : #order }
MethodShouldBeImplementedAction >> actionOrder [
	"Return the priority of this action"
	
	^ 90
]

{ #category : #order }
MethodShouldBeImplementedAction >> isActionHandled [	
	^ method markerOrNil = #shouldBeImplemented
]

{ #category : #order }
MethodShouldBeImplementedAction >> privateActionIcon [
	"Return the icon for this action"
	| anIcon |
			
	anIcon := self iconNamed: #smallError.

	^ IconicButton new 
		target: method;
		actionSelector: #browse;
		labelGraphic: anIcon;
		color: Color transparent;
		extent: self iconExtent;
		helpText: 'Method should be implemented';
		borderWidth: 0
]
