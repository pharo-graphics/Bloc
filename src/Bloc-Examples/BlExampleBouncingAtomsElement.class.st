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
BlExampleBouncingAtomsElement >> initialize [
	super initialize.
	
	self enqueueTask: (BlRepeatedTaskAction new delay: 0 milliSeconds; action: [ self step ]).
	damageReported := false
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
		
	super invalidRect: (self invalidationBounds: self class invalidationBounds) from: anElement.
		
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

	r := self bounds topLeft corner: (self bounds extent - (8@8)).
	self childrenDo: [ :m | m bounceIn: r ]
]
