"
I am an atom that bounces inside a ${class:name=BlExampleBouncingAtomsElement}$. 
For a demo, inspect:
[[[
BlExampleBouncingAtomsElement demo
]]]

"
Class {
	#name : #BlExampleAtomElement,
	#superclass : #BlElement,
	#instVars : [
		'velocity'
	],
	#category : #'Bloc-Examples-Showcase - Bouncing Atoms'
}

{ #category : #accessing }
BlExampleAtomElement class >> defaultSize [
	^ 8 @ 7
]

{ #category : #private }
BlExampleAtomElement >> bounceIn: aRect [
	"Move this atom one step along its velocity vector and make it bounce if it goes outside the given rectangle. Return true if it is bounced."
	| p vx vy px py bounced |

	p := self measuredBounds position.

	vx := velocity x.
	vy := velocity y.

	px := p x + vx.		py := p y + vy.

	bounced := false.

	px > aRect right ifTrue: [
		px := aRect right - (px - aRect right).
		vx := velocity x negated.
		bounced := true].
	py > aRect bottom ifTrue: [
		py :=  aRect bottom - (py - aRect bottom).
		vy := velocity y negated.
		bounced := true].
	px < aRect left ifTrue: [
		px := aRect left - (px - aRect left).
		vx := velocity x negated.
		bounced := true].
	py < aRect top ifTrue: [
		py :=  aRect top - (py - aRect top).
		vy := velocity y negated.
		bounced := true].
	self relocate: px @ py.
	bounced ifTrue: [self velocity: vx @ vy].
	^ bounced

]

{ #category : #drawing }
BlExampleAtomElement >> fullDrawOnSpartaCanvas: aCanvas [
	aCanvas fill
		path: (self bounds inParent asRectangle);
		paint: Color blue;
		draw
]

{ #category : #private }
BlExampleAtomElement >> initialize [
	"Make a new atom with a random position and velocity."

	super initialize.
	self size: self class defaultSize.
	self background: Color red.
	self addEventHandler: BlPullHandler new.
	self
		addEventHandler:
			(BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | self phlow spawnObject: self ])
]

{ #category : #accessing }
BlExampleAtomElement >> velocity [
	^ velocity
]

{ #category : #accessing }
BlExampleAtomElement >> velocity: anObject [
	velocity := anObject
]
