Class {
	#name : #GLMBlocMatrixElement,
	#superclass : #BlElement,
	#instVars : [
		'gridElement',
		'leftParentheses',
		'rightParentheses'
	],
	#category : #'Bloc-Extensions-UI'
}

{ #category : #'instance creation' }
GLMBlocMatrixElement >> asCellText: aString [

	^ aString asRopedText fontName: 'STIXGeneral'
]

{ #category : #'instance creation' }
GLMBlocMatrixElement >> asParenthesesText: aString [
	^ aString asRopedText thin
]

{ #category : #'instance creation' }
GLMBlocMatrixElement >> asScalableElement: anElement [
	^ BlElement new
		addChild: anElement;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal exact: 20 ]
]

{ #category : #initialization }
GLMBlocMatrixElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
GLMBlocMatrixElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	leftParentheses := self newParenthesesElement.
	leftParentheses text: (self asParenthesesText: '⟮').

	rightParentheses := self newParenthesesElement.
	rightParentheses text: (self asParenthesesText: '⟯').

	gridElement := self newGridElement.
	
	self addChildren: { self asScalableElement: leftParentheses . gridElement . self asScalableElement: rightParentheses }
]

{ #category : #accessing }
GLMBlocMatrixElement >> matrix: aMatrix [
	| theCellElements |

	gridElement layoutDo: [ :l |
		l columnCount: aMatrix columnCount.
		l cellSpacing: 3 ].
	
	theCellElements := aMatrix collect: [ :aNumber |
		| textCell numberString |
		
		numberString := ((aNumber closeTo: aNumber integerPart)
			ifTrue: [ aNumber asInteger ]
			ifFalse: [ (aNumber round: 2) ]) printString.
		
		textCell := self newCellElement
			text: (self asCellText: numberString);
			constraintsDo: [ :c |
				c grid horizontal alignCenter ]
			
	] as: Array.

	gridElement addChildren: theCellElements
]

{ #category : #'instance creation' }
GLMBlocMatrixElement >> newCellElement [

	^ BlTextElement new
		padding: (BlInsets all: 2)
]

{ #category : #'instance creation' }
GLMBlocMatrixElement >> newGridElement [

	^ BlElement new
		layout: BlGridLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #'instance creation' }
GLMBlocMatrixElement >> newParenthesesElement [
	^ BlTextElement new
		padding: (BlInsets left: 2 right: 2)
]

{ #category : #layout }
GLMBlocMatrixElement >> onLayout: aBounds [
	| leftScale rightScale |
	super onLayout: aBounds.

	leftScale := (leftParentheses parent extent / leftParentheses extent) asFloatPoint.
	rightScale := (rightParentheses parent extent / rightParentheses extent) asFloatPoint.

	leftParentheses transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: leftScale x y: leftScale y z: 1);
		apply.

	rightParentheses transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: rightScale x y: rightScale y z: 1);
		apply
]
