Class {
	#name : #BlBlurringClipper,
	#superclass : #BlElement,
	#instVars : [
		'top',
		'left',
		'right',
		'bottom',
		'center',
		'middle'
	],
	#category : #'Bloc-Examples-Scrolling'
}

{ #category : #'instance creation' }
BlBlurringClipper class >> on: anElement [
	^ self new contentElement: anElement
]

{ #category : #initialization }
BlBlurringClipper >> contentElement: anElement [
	anElement clipChildren: false.
	anElement effect: (BlGaussianShadowEffect
		color: (Color black alpha: 0.3)
		width: 2
		offset: 0 @ 1).

	anElement margin: (BlInsets all: 3).

	middle replaceChild: center with: anElement.

	center := anElement
]

{ #category : #initialization }
BlBlurringClipper >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	top := self newAreaElement.
	
	middle := self newAreaElement
		layout: BlLinearLayout horizontal;
		elevation: (BlRelativeElevation elevation: 0);
		clipChildren: false;
		constraintsDo: [ :c | c vertical fitContent ].
	left := self newAreaElement.
	center := BlElement new
		background: Color gray;
		size: 100@100.
	right := self newAreaElement.
	
	middle addChildren: { left . center . right }.
		
	bottom := self newAreaElement.
	
	self addChildren: { top . middle . bottom }
]

{ #category : #initialization }
BlBlurringClipper >> newAreaElement [
	^ BlElement new
		elevation: (BlRelativeElevation elevation: 1);
		background: (Color white alpha: 0.85);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]
]
