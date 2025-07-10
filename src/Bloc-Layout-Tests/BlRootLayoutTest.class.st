Class {
	#name : #BlRootLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #testing }
BlRootLayoutTest class >> isAbstract [ 
	^ self name = 'BlRootLayoutTest'
	
]

{ #category : #testing }
BlRootLayoutTest class >> shouldInheritSelectors [
	^ true
	
]

{ #category : #assertions }
BlRootLayoutTest >> assertExactConstraint: aPoint forElement: anElement [
	self assert: anElement constraints horizontal resizer size equals: aPoint x.
	self assert: anElement constraints vertical resizer size equals: aPoint y.
]

{ #category : #helpers }
BlRootLayoutTest >> childExact: aPoint [
	^ self testChildElementWithVisualProperties
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #helpers }
BlRootLayoutTest >> childExactHeight: aNumber [
	^ self testChildElementWithVisualProperties
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #helpers }
BlRootLayoutTest >> childExactWidth: aNumber [
	^ self testChildElementWithVisualProperties
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #tests }
BlRootLayoutTest >> parentWithFixedExtent [
	<sampleInstance>
	
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		extent: 400@300;
		yourself.
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 400.
	self assert: element constraints vertical resizer size equals: 300.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	
	^ element
]

{ #category : #tests }
BlRootLayoutTest >> testChildElementMatchingParent [
	<sampleInstance>
	| element |
	element := self testChildElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	
	^ element
]

{ #category : #tests }
BlRootLayoutTest >> testChildElementWithVisualProperties [
	<sampleInstance>
	| element |
	element :=  BlElement new
		background: (Color cyan alpha: 0.2);
		border: (BlBorder builder paint: (Color blue alpha: 0.5); width: 1; build);
		yourself.
	
	self assert: element border width equals: 1.
	self assert: element border paint equals: (Color blue alpha: 0.5) asBlPaint.
	self assert: element background equals: (Color cyan alpha: 0.2) asBlBackground.
		
	^ element
]

{ #category : #tests }
BlRootLayoutTest >> testParentWithFixedSize [
	<sampleInstance>
	
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		extent: 400@300;
		yourself.
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 400.
	self assert: element constraints vertical resizer size equals: 300.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	
	^ element
]
