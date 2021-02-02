Trait {
	#name : #TBlLayoutExamplesSetup,
	#category : #'Bloc-Layout-Examples-Core'
}

{ #category : #assertions }
TBlLayoutExamplesSetup >> assertExactConstraint: aPoint forElement: anElement [
	self assert: anElement constraints horizontal resizer size equals: aPoint x.
	self assert: anElement constraints vertical resizer size equals: aPoint y.
]

{ #category : #'examples - setup' }
TBlLayoutExamplesSetup >> childElementMatchingParent [
	<gtExample>
	| element |
	element := self childElementWithVisualProperties.
	element constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer isMatchParent.
	self assert: element constraints vertical resizer isMatchParent.
	
	^ element
]

{ #category : #'examples - setup' }
TBlLayoutExamplesSetup >> childElementWithVisualProperties [
	<gtExample>
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

{ #category : #factories }
TBlLayoutExamplesSetup >> childExact: aPoint [
	^ self childElementWithVisualProperties
		constraintsDo: [ :c |
			c horizontal exact: aPoint x.
			c vertical exact: aPoint y ];
		yourself
]

{ #category : #factories }
TBlLayoutExamplesSetup >> childExactHeight: aNumber [
	^ self childElementWithVisualProperties
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself
]

{ #category : #factories }
TBlLayoutExamplesSetup >> childExactWidth: aNumber [
	^ self childElementWithVisualProperties
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself
]

{ #category : #'examples - setup' }
TBlLayoutExamplesSetup >> parentWithFixedSize [
	<gtExample>
	| element |
	element :=  BlElement new
		border: (BlBorder builder dashed; paint: Color red; width: 3; build);
		size: 400@300;
		yourself.
		
	self assert: element position equals: 0@0.
	self assert: element extent equals: 0@0.
	self assert: element constraints horizontal resizer size equals: 400.
	self assert: element constraints vertical resizer size equals: 300.
	self assert: element border width equals: 3.
	self assert: element border paint equals: Color red asBlPaint.
	
	^ element
]
