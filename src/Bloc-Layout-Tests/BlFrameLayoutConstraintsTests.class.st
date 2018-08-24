Class {
	#name : #BlFrameLayoutConstraintsTests,
	#superclass : #TestCase,
	#instVars : [
		'parent',
		'child'
	],
	#category : 'Bloc-Layout-Tests-Frame'
}

{ #category : #running }
BlFrameLayoutConstraintsTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlFrameLayout new.
	
	child := BlElement new.
	
	parent addChild: child
]

{ #category : #running }
BlFrameLayoutConstraintsTests >> tearDown [
	super tearDown.
	
	parent := nil.
	child := nil
]

{ #category : #tests }
BlFrameLayoutConstraintsTests >> testConstraintsConsistent [
	| constraintsA constraintsB |
	
	constraintsA := child constraints frame.
	constraintsB := child constraints frame.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB
]

{ #category : #tests }
BlFrameLayoutConstraintsTests >> testConstraintsExist [
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints frame.
	self assert: (constraints isKindOf: BlFrameLayoutConstraints)
]
