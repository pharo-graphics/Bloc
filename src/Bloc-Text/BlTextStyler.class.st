"
I am responsible for applying text attributes on ${class:BlText}$ based on some logic, for example it can be code syntax highlighting.

I am independent from the text editor.
The main entrance point is 
"
Class {
	#name : #BlTextStyler,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'text',
		'stylingEnabled',
		'eventDispatcher'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #'event management accessing' }
BlTextStyler >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #styling }
BlTextStyler >> fireStyledEventForText: aStyledText andAfterAction: aBlock [
	"This method must be called from a Bloc UI process only."
	self fireEvent: (BlTextStyledEvent new text: aStyledText; afterAction: aBlock)
]

{ #category : #'gt-extension' }
BlTextStyler >> gtStylesFor: aView [
	<gtView>
	
	self stylers
		ifEmpty: [ ^ aView empty ].
	
	^ aView tree
		title: 'Styles';
		priority: 5;
		items: [ { self } ];
		children: #stylers;
		expandAll
]

{ #category : #initialization }
BlTextStyler >> initialize [
	super initialize.
	
	stylingEnabled := true.
	eventDispatcher := BlDirectEventDispatcher on: self.
]

{ #category : #private }
BlTextStyler >> privateStyle: aText [ 
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #styling }
BlTextStyler >> style: aBlText [
	| anUnstyledText aStyledText |
	<return: #BlText>
	stylingEnabled
		ifFalse: [ ^ aBlText ].
		
	anUnstyledText := aBlText unstyle.
	aStyledText := self privateStyle: anUnstyledText characters.
	^ aStyledText text
]

{ #category : #accessing }
BlTextStyler >> stylers [
	"In case of a composite styler, return children stylers"
	<return: #Collection of: #BlTextStyler>

	^ #()
]

{ #category : #private }
BlTextStyler >> stylingEnabled [
	^ stylingEnabled
]

{ #category : #private }
BlTextStyler >> stylingEnabled: aBoolean [
	stylingEnabled := aBoolean
]
