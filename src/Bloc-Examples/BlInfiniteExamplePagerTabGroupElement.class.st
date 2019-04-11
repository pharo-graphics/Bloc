Class {
	#name : #BlInfiniteExamplePagerTabGroupElement,
	#superclass : #BlElement,
	#instVars : [
		'labelsElement',
		'contentElement'
	],
	#category : #'Bloc-Examples-Infinite'
}

{ #category : #adding }
BlInfiniteExamplePagerTabGroupElement >> addTab: anElement titled: aString [
	| tabLabel |
	
	tabLabel := self newTabLabel.
	tabLabel text: (BlRopedText string: aString).
	tabLabel
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent |
			labelsElement childrenDo: [ :aLabel | aLabel background: BlBackground transparent ].
			anEvent currentTarget background: Color veryVeryLightGray.
			contentElement removeChildren.
			contentElement addChild: anElement ].
	
	labelsElement addChild: tabLabel.
	
	contentElement hasChildren
		ifFalse: [
			contentElement addChild: anElement.
			tabLabel background: Color veryVeryLightGray. ]
]

{ #category : #initialization }
BlInfiniteExamplePagerTabGroupElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	
	labelsElement := BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
		
	contentElement := BlElement new
		layout: BlLinearLayout new;
		background: Color veryVeryLightGray;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
		
	self addChildren: { labelsElement . contentElement }
]

{ #category : #'instance creation' }
BlInfiniteExamplePagerTabGroupElement >> newTabLabel [
	^ BlTextElement new
		padding: (BlInsets all: 10)
]
