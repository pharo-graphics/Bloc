Class {
	#name : #BlFlowLayoutChild,
	#superclass : #Object,
	#instVars : [
		'width',
		'height',
		'margin',
		'weight',
		'newLine',
		'startLength',
		'startBreadth',
		'element',
		'alignment',
		'measurer',
		'display'
	],
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #'instance creation' }
BlFlowLayoutChild class >> measurer: aMeasurer element: aChildElement [
	^ self new
		measurer: aMeasurer element: aChildElement;
		yourself
]

{ #category : #adding }
BlFlowLayoutChild >> addToLine: aLine [
	self subclassResponsibility
]

{ #category : #accessing }
BlFlowLayoutChild >> alignment [
	^ alignment
]

{ #category : #accessing }
BlFlowLayoutChild >> alignment: anAlignment [
	alignment := anAlignment
]

{ #category : #geometry }
BlFlowLayoutChild >> breadth [
	^ self orientation breadthOf: self
]

{ #category : #accessing }
BlFlowLayoutChild >> direction [
	^ measurer direction
]

{ #category : #accessing }
BlFlowLayoutChild >> display [
	^ display
]

{ #category : #accessing }
BlFlowLayoutChild >> display: aDisplay [
	"float or inline"
	display := aDisplay
]

{ #category : #accessing }
BlFlowLayoutChild >> element [
	^ element
]

{ #category : #geometry }
BlFlowLayoutChild >> height [
	^ height
]

{ #category : #geometry }
BlFlowLayoutChild >> height: aNumber [
	height := aNumber
]

{ #category : #geometry }
BlFlowLayoutChild >> inlineX [
	^ self orientation inlineX: self
]

{ #category : #geometry }
BlFlowLayoutChild >> inlineY [
	^ self orientation inlineY: self
]

{ #category : #testing }
BlFlowLayoutChild >> isFloating [
	^ display isFloating
]

{ #category : #testing }
BlFlowLayoutChild >> isInline [
	^ display isInline
]

{ #category : #testing }
BlFlowLayoutChild >> isNewLine [
	^ newLine
]

{ #category : #geometry }
BlFlowLayoutChild >> length [
	^ self orientation lengthOf: self
]

{ #category : #accessing }
BlFlowLayoutChild >> margin [
	^ margin
]

{ #category : #accessing }
BlFlowLayoutChild >> margin: aMargin [
	margin := aMargin
]

{ #category : #accessing }
BlFlowLayoutChild >> marginBottom [
	^ margin bottom
]

{ #category : #accessing }
BlFlowLayoutChild >> marginLeft [
	^ margin left
]

{ #category : #accessing }
BlFlowLayoutChild >> marginRight [
	^ margin right
]

{ #category : #accessing }
BlFlowLayoutChild >> marginTop [
	^ margin top
]

{ #category : #initialization }
BlFlowLayoutChild >> measurer: aMeasurer element: aChildElement [
	measurer := aMeasurer.
	element := aChildElement
]

{ #category : #accessing }
BlFlowLayoutChild >> newLine: aBoolean [
	newLine := aBoolean
]

{ #category : #accessing }
BlFlowLayoutChild >> orientation [
	^ measurer orientation
]

{ #category : #geometry }
BlFlowLayoutChild >> spacingBreadth [
	^ self orientation spacingBreadthOf: self
]

{ #category : #geometry }
BlFlowLayoutChild >> spacingLength [
	^ self orientation spacingLengthOf: self
]

{ #category : #accessing }
BlFlowLayoutChild >> startBreadth [
	^ startBreadth
]

{ #category : #accessing }
BlFlowLayoutChild >> startBreadth: aNumber [
	startBreadth := aNumber
]

{ #category : #accessing }
BlFlowLayoutChild >> startLength [
	^ startLength
]

{ #category : #accessing }
BlFlowLayoutChild >> startLength: aNumber [
	startLength := aNumber
]

{ #category : #geometry }
BlFlowLayoutChild >> totalBreadth [
	^ self breadth + self spacingBreadth
]

{ #category : #geometry }
BlFlowLayoutChild >> totalLength [
	^ self length + self spacingLength
]

{ #category : #accessing }
BlFlowLayoutChild >> weight [
	^ weight
]

{ #category : #accessing }
BlFlowLayoutChild >> weight: aNumber [
	weight := aNumber
]

{ #category : #geometry }
BlFlowLayoutChild >> width [
	^ width
]

{ #category : #geometry }
BlFlowLayoutChild >> width: aNumber [
	width := aNumber
]
