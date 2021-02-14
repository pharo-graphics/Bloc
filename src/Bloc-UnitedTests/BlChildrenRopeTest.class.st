"
I have been automatically converted and probably manually tweaked from BlChildrenRopeExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlChildrenRopeTest,
	#superclass : #TestCase,
	#traits : 'TBlChildrenTest',
	#classTraits : 'TBlChildrenTest classTrait',
	#category : #'Bloc-UnitedTests-Rope'
}

{ #category : #fixture }
BlChildrenRopeTest >> newChildrenCollection [
	^ BlChildrenRope new
]

{ #category : #metadata }
BlChildrenRopeTest >> originClassName [
	"This test was generated from..."
	^ 'BlChildrenRopeExamples'
]

{ #category : #tests }
BlChildrenRopeTest >> testEmptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |
	theChildren := BlChildrenRope new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.
	^ theChildren
]
