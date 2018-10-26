"
I contain ""integration"" examples of the grid, linear, flow and frame layouts
"
Class {
	#name : #BlLayoutExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Layout'
}

{ #category : #examples }
BlLayoutExamples >> complexVerticalFitContent [
	<gtExample>
	| grid list flow |
	
	grid := BlElement new.
	grid layout: (BlGridLayout horizontal).
	grid constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	grid background: Color gray.
	grid padding: (BlInsets top: 20).
	grid addChild: (self layoutLabel: 'Grid').

	list := BlElement new.
	list layout: BlLinearLayout vertical.
	list constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	flow := BlElement new.
	flow layout: BlFlowLayout horizontal.
	flow constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	flow addChildren: {
		BlElement new size: 100@75; background: Color red.
		BlElement new size: 75@100; background: Color blue }.

	list addChild: flow.
	grid addChild: list.

	grid forceLayout.
	
	"self assert: grid extent equals: 300@100.
	self assert: list extent equals: 300@100.
	self assert: flow extent equals: 300@100."
	
	^ grid
]

{ #category : #'instance creation' }
BlLayoutExamples >> layoutLabel: aString [
	^ BlTextElement new
		text: ('Grid' asRopedText thin fontSize: 10);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignCenter ]
]
