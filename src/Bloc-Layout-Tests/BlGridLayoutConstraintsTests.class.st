Class {
	#name : #BlGridLayoutConstraintsTests,
	#superclass : #TestCase,
	#instVars : [
		'parent',
		'child'
	],
	#category : 'Bloc-Layout-Tests-Grid'
}

{ #category : #running }
BlGridLayoutConstraintsTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlGridLayout horizontal.
	
	child := BlElement new.
	
	parent addChild: child
]

{ #category : #running }
BlGridLayoutConstraintsTests >> tearDown [
	super tearDown.
	
	parent := nil.
	child := nil
]

{ #category : #tests }
BlGridLayoutConstraintsTests >> testConstraintsConsistent [
	| constraintsA constraintsB |
	
	constraintsA := child constraints grid.
	constraintsB := child constraints grid.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB
]

{ #category : #tests }
BlGridLayoutConstraintsTests >> testConstraintsExist [
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints grid.
	self assert: (constraints isKindOf: BlGridLayoutConstraints)
]
