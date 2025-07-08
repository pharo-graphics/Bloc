Class {
	#name : #BlSelectionTool,
	#superclass : #BlEventListener,
	#instVars : [
		'selectionRect',
		'client',
		'startPosition',
		'endPosition',
		'currentSelections'
	],
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'as yet unclassified' }
BlSelectionTool >> buildSelection [
	|area selectedNodes|
	area := Rectangle origin: startPosition corner: endPosition.

	selectedNodes := client children select: [ :each | area containsRect: each bounds inParent asRectangle].
	selectedNodes do: [ :each | currentSelections add: (BlElementSelection on: each)].
]

{ #category : #'as yet unclassified' }
BlSelectionTool >> clickEvent: anEvent [
	"self resetCurrentSelections."
	
]

{ #category : #'as yet unclassified' }
BlSelectionTool >> dragEndEvent: anEvent [
	endPosition := anEvent position.
	client removeChild: selectionRect.
	self buildSelection.
]

{ #category : #'dnd handlers' }
BlSelectionTool >> dragEvent: anEvent [
	selectionRect extent: anEvent position - startPosition
]

{ #category : #'dnd handlers' }
BlSelectionTool >> dragStartEvent: anEvent [

	anEvent consume.
	self resetCurrentSelections.
	startPosition := anEvent position.
	selectionRect extent:50@50; position:startPosition.
	client addChild: selectionRect 
]

{ #category : #initialization }
BlSelectionTool >> initialize [
	super initialize.
	currentSelections := OrderedCollection new.
	selectionRect := BlElement new
		zIndex: 1000;
		extent: 50@50;
		background: Color transparent;
		border:
			(BlBorder
				paint: Color black
				width: 1);
		yourself
]

{ #category : #'as yet unclassified' }
BlSelectionTool >> onInstalledIn: anObject [
	client := anObject
]

{ #category : #'as yet unclassified' }
BlSelectionTool >> resetCurrentSelections [
	currentSelections do: [ :each | each removeFromParent ].
	currentSelections removeAll.
]
