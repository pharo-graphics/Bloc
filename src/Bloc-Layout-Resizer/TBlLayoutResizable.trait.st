Trait {
	#name : #TBlLayoutResizable,
	#category : #'Bloc-Layout-Resizer'
}

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> exact: aPoint [

	| aSize |
	aSize := aPoint asPoint.
	self sizeConstraintsDo: [ :c |
		c horizontal exact: aSize x.
		c vertical exact: aSize y ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> fitContent [

	self sizeConstraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> fitContentLimited [

	self sizeConstraintsDo: [ :c |
		c horizontal fitContentLimited.
		c vertical fitContentLimited ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self sizeConstraintsDo: [ :c |
		(c horizontal isExact and: [ c horizontal resizer size = aNumber ])
			ifFalse: [ c horizontal exact: aNumber ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hFitContent [

	self sizeConstraintsDo: [ :c |
		c horizontal isFitContent ifFalse: [ c horizontal fitContent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hFitContentLimited [

	self sizeConstraintsDo: [ :c | c horizontal fitContentLimited ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hMatchParent [

	self sizeConstraintsDo: [ :c |
		c horizontal isMatchParent ifFalse: [ c horizontal matchParent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> matchParent [

	self sizeConstraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> sizeConstraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	user can implement additional actions by handling the BlLayoutConstraintsChangedEvent
	"

	| hr vr |
	hr := self constraints horizontal resizer.
	vr := self constraints vertical resizer.
	aBlock value: self constraints.
	(hr = self constraints horizontal resizer and: [
		 vr = self constraints vertical resizer ]) ifTrue: [ ^ self ].
	self dispatchEvent: BlLayoutConstraintsChangedEvent new.
	self requestLayout
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self sizeConstraintsDo: [ :c |
		(c vertical isExact and: [ c vertical resizer size = aNumber ])
			ifFalse: [ c vertical exact: aNumber ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vFitContent [

	self sizeConstraintsDo: [ :c |
		c vertical isFitContent ifFalse: [ c vertical fitContent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vFitContentLimited [
	
	self sizeConstraintsDo: [ :c | c vertical fitContentLimited ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vMatchParent [

	self sizeConstraintsDo: [ :c |
		c vertical isMatchParent ifFalse: [ c vertical matchParent ] ]
]
