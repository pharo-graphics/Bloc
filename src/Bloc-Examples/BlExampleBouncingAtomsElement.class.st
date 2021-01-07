"
I am a port of the old BouncingAtomsMorph demo.

The following will open a demo in a new window:
[[[
BlExampleBouncingAtomsElement open
]]]

Alternatively inspect the following:
[[[
BlExampleBouncingAtomsElement demo 
]]]

For a demo, open a new Inspector window.
Inspect the children and select a random one.
Set its background color to blue (self background: Color blue).
Query and set its velocity to 0@0 and 20@20, and its size to 10@10.

"
Class {
	#name : #BlExampleBouncingAtomsElement,
	#superclass : #BlElement,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#instVars : [
		'damageReported'
	],
	#category : #'Bloc-Examples-Showcase - Bouncing Atoms'
}

{ #category : #accessing }
BlExampleBouncingAtomsElement class >> demo [
	<script: 'self demo'>
	^ self new
		background: Color lightGreen;
		border: (BlBorder paint: Color green width: 1);
		initializeWith: 300 ofSize: 5 @ 5 within: 400 @ 300
]

{ #category : #'instance creation' }
BlExampleBouncingAtomsElement class >> open [
	<script: 'self open'>

	self
		openInWindow: (self new initializeWith: 3000 ofSize: 5@5 within: 1200@800)
		named: 'Bouncing Atoms'
		extent: 1200@800
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> addAtoms: aCollectionOfAtomElements ofSize: anAtomSize within: anSceneExtent [
	"Add a bunch of new atoms."

	aCollectionOfAtomElements do: [ :anAtomElement |
		anAtomElement size: anAtomSize.
		self
			randomizePositionOf: anAtomElement
			in: (0@0 extent: anSceneExtent)
			maxVelocity: 3
			extent: anAtomSize ].

	self addChildren: aCollectionOfAtomElements
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	super drawMeAndChildrenOnSpartaCanvas: aCanvas.
	damageReported := false
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> go [
	"Start the animation"
	
	self enqueueTask: (BlRepeatedTaskAction new delay: 0 milliSeconds; action: [ self step ]).
	damageReported := false
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> initialize [
	super initialize.
	self go
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> initializeWith: aNumberOfAtoms ofSize: anAtomExtent within: aSceneExtent [
	self size: aSceneExtent.
	self
		addAtoms: (aNumberOfAtoms timesCollect: [ self newAtom ])
		ofSize: anAtomExtent
		within: aSceneExtent
]

{ #category : #'change reporting' }
BlExampleBouncingAtomsElement >> invalidRect: aBlBounds from: anElement [
	damageReported
		ifTrue: [ ^ self ].

	super invalidRect: (self invalidationBounds) from: anElement.
		
	damageReported := true
]

{ #category : #'instance creation' }
BlExampleBouncingAtomsElement >> newAtom [
	^ BlExampleAtomElement new
]

{ #category : #initialization }
BlExampleBouncingAtomsElement >> randomizePositionOf: anAtomElement in: aRectangle maxVelocity: maxVelocity extent: anAtomExtent [
	"Give this atom a random position and velocity"
	| anExtent |

	anExtent := (aRectangle extent - anAtomExtent) rounded.

	anAtomElement relocate: (anExtent x atRandom) @ (anExtent y atRandom).
	anAtomElement velocity: (maxVelocity - (2 * maxVelocity) atRandom) @ (maxVelocity - (2 * maxVelocity) atRandom)
]

{ #category : #'stepping and presenter' }
BlExampleBouncingAtomsElement >> step [
	"Bounce those atoms!"

	| r |
	r := self measuredBounds topLeft
		corner: self bounds extent - BlExampleAtomElement defaultSize.
	self childrenDo: [ :m | m bounceIn: r ]
]
