"
How to run:


==BlChicken open==
"
Class {
	#name : #BlChicken,
	#superclass : #BlElement,
	#category : #'Bloc-Examples-Showcase-Chicken'
}

{ #category : #examples }
BlChicken class >> chicken [
	<gtExample>
	
	^ self new size: 300@450
]

{ #category : #examples }
BlChicken class >> open [
	<script: 'self open'>
	| space chicken |
	
	space := BlSpace new.
	space extent: 300 @ 500.
	space title: 'Software chicken'.
	
	chicken := self chicken.
	chicken constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	space root addChild: chicken.
	space root
		addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | BlElementSelection on: evt target ]).
	space show
]

{ #category : #initialization }
BlChicken >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	
	self addChildren: { 
		BlElement new
			layout: (BlLinearLayout horizontal weightSum: 1);
			constraintsDo: [ :c |
				c linear weight: 0.2.
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: {
				BlElement new
					constraintsDo: [ :c |
						c linear weight: 0.35.
						c horizontal matchParent.
						c vertical matchParent ].
				BlChickenHead new
					constraintsDo: [ :c |
						c linear weight: 0.3.
						c horizontal matchParent.
						c vertical matchParent ].
				BlElement new
					constraintsDo: [ :c |
						c linear weight: 0.35.
						c horizontal matchParent.
						c vertical matchParent ] }.
		BlChickenBody new
			constraintsDo: [ :c |
				c linear weight: 0.6.
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.
			
		BlElement new
			layout: (BlLinearLayout horizontal weightSum: 1);
			constraintsDo: [ :c |
				c linear weight: 0.2.
				c horizontal matchParent.
				c vertical matchParent ];
			addChildren: { 
				BlElement new
					constraintsDo: [ :c |
						c linear weight: 0.2.
						c horizontal matchParent.
						c vertical matchParent ].
				BlChickenLeg new
					constraintsDo: [ :c |
						c linear weight: 0.3.
						c horizontal matchParent.
						c vertical matchParent ];
					margin: (BlInsets right: 5).
				BlChickenLeg new
					constraintsDo: [ :c |
						c linear weight: 0.3.
						c horizontal matchParent.
						c vertical matchParent ];
					margin: (BlInsets left: 5).
				BlElement new
					constraintsDo: [ :c |
						c linear weight: 0.2.
						c horizontal matchParent.
						c vertical matchParent ]
			} }
]
