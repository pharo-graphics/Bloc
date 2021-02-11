Class {
	#name : #BlElementLayoutBoundaryExamplesMigrated,
	#superclass : #BlElementExamplesMigrated,
	#category : #'Bloc-Examples-BasicMigrated'
}

{ #category : #examples }
BlElementLayoutBoundaryExamplesMigrated >> exactLayoutBoundary_01_pulse [
	<gtExample>
	| aSpace |
	
	aSpace := self spaceWithExactLayoutBoundary.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #child) extent equals: 300@200.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #examples }
BlElementLayoutBoundaryExamplesMigrated >> exactLayoutBoundary_02_requestLayoutChild [
	<gtExample>
	| aSpace |
	
	aSpace := self exactLayoutBoundary_01_pulse.
	
	(aSpace root childNamed: #child) requestLayout.
	
	self assert: aSpace isLayoutRequested.
	self assert: aSpace elementsNeedingLayout equals: { aSpace root childNamed: #boundary } asSet.
	
	aSpace pulse.
	
	self assert: aSpace root extent equals: 500@400.
	self assert: (aSpace root childNamed: #container) extent equals: 400@300.
	self assert: (aSpace root childNamed: #boundary) extent equals: 300@200.
	self assert: (aSpace root childNamed: #child) extent equals: 300@200.
	
	self assert: aSpace isLayoutRequested not.
	self assert: aSpace elementsNeedingLayout isEmpty.
	
	^ aSpace
]

{ #category : #'instance creation' }
BlElementLayoutBoundaryExamplesMigrated >> spaceWithExactLayoutBoundary [
	<gtExample>
	| aSpace aContainer aLayoutBoundary aChild |
	
	aSpace := BlSpace new.
	aSpace extent: 500@400.
	
	aContainer := BlElement new
		size: 400@300.
		
	aLayoutBoundary := BlElement new
		size: 300@200.
		
	aChild := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
		
	self assert: aLayoutBoundary isLayoutBoundary.
	self assert: aChild isLayoutBoundary.

	aLayoutBoundary addChild: aChild as: #child.
	aContainer addChild: aLayoutBoundary as: #boundary.
	aSpace root addChild: aContainer as: #container.
		
	^ aSpace
]
