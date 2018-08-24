Class {
	#name : #BlLinearLayoutConstraintsTests,
	#superclass : #TestCase,
	#instVars : [
		'parent',
		'child'
	],
	#category : 'Bloc-Layout-Tests-Linear'
}

{ #category : #running }
BlLinearLayoutConstraintsTests >> setUp [
	super setUp.
	
	parent := BlElement new.
	parent layout: BlLinearLayout vertical.
	
	child := BlElement new.
	
	parent addChild: child
]

{ #category : #running }
BlLinearLayoutConstraintsTests >> tearDown [
	super tearDown.
	
	parent := nil.
	child := nil
]

{ #category : #tests }
BlLinearLayoutConstraintsTests >> testConstraintsConsistent [
	| constraintsA constraintsB |
	
	constraintsA := child constraints linear.
	constraintsB := child constraints linear.
	
	"compare by identity to make sure that constraints refer to the same object"
	self assert: constraintsA == constraintsB
]

{ #category : #tests }
BlLinearLayoutConstraintsTests >> testConstraintsExist [
	| constraints |

	self assert: child constraints class equals: BlLayoutCommonConstraints.
	
	constraints := child constraints linear.
	self assert: (constraints isKindOf: BlLinearLayoutConstraints)
]
