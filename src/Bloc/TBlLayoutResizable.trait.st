Trait {
	#name : #TBlLayoutResizable,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> exact: aPoint [

	self resizerDo: [ :c |
			| anExtent |
			anExtent := aPoint asPoint.
			(self isExact: aPoint) ifFalse: [
					c horizontal exact: anExtent x.
					c vertical exact: anExtent y ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> exactOrFitContent [

	self hExactOrFitContent.
	self vExactOrFitContent 
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> fitContent [

	self resizerDo: [ :c |
			(self isHFitContent and: [ self isVFitContent ]) ifTrue: [ ^ self ].
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> fitContentLimited [

	self resizerDo: [ :c |
			(self isHFitContentLimited and: [ self isVFitContentLimited ])
				ifTrue: [ ^ self ].
			c horizontal fitContentLimited.
			c vertical fitContentLimited ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> fitElement: anElement [

	self hFitElement: anElement.
	self vFitElement: anElement
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> fitParent: anElement [

	self hFitParent: anElement.
	self vFitParent: anElement
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self resizerDo: [ :c |
			(self isHExact: aNumber) ifFalse: [
				c horizontal exact: aNumber ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hExactOrFitContent [

	self isHExact ifFalse: [ self hFitContent ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hFitContent [

	self resizerDo: [ :c |
		self isHFitContent ifFalse: [
			c horizontal fitContent ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hFitContentLimited [

	self resizerDo: [ :c |
		self isHFitContentLimited ifFalse: [ c horizontal fitContentLimited ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hFitElement: anElement [

	anElement isHMatchParent ifTrue: [ ^ self hMatchParent ].
	self hFitContent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hFitParent: anElement [

	anElement isHFitContent ifTrue: [ ^ self hFitContent ].
	self hMatchParent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> hMatchParent [

	self resizerDo: [ :c |
		self isHMatchParent ifFalse: [ c horizontal matchParent ] ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isExact [

	^ self isHExact and: [ self isVExact ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isExact: aPoint [

	^ (self isHExact: aPoint x) and: [ self isVExact: aPoint y ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHExact [

	^ self constraints horizontal resizer isExact
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHExact: aSize [

	| c |
	c := self constraints.
	^ c horizontal resizer isExact and: [
		  c horizontal resizer size = aSize ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHFitContent [

	^ self constraints horizontal resizer isFitContent
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHFitContentLimited [

	^ self constraints horizontal resizer isFitContentLimited
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHMatchParent [

	^ self constraints horizontal resizer isMatchParent
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isMatchParent [

	^ self isHMatchParent and: [ self isVMatchParent ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isVExact [

	^ self constraints vertical resizer isExact
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isVExact: aSize [

	| c |
	c := self constraints.
	^ c vertical resizer isExact and: [
		  c vertical resizer size = aSize ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isVFitContent [

	^ self constraints vertical resizer isFitContent
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isVFitContentLimited [

	^ self constraints vertical resizer isFitContentLimited
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isVMatchParent [

	^ self constraints vertical resizer isMatchParent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> matchParent [

	self hMatchParent.
	self vMatchParent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> resizerDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument
	user can implement additional actions by handling the BlLayoutResizerChangedEvent
	"

	| hr vr |
	hr := self constraints horizontal resizer.
	vr := self constraints vertical resizer.
	aBlock value: self constraints.
	(hr = self constraints horizontal resizer and: [
		 vr = self constraints vertical resizer ]) ifTrue: [ ^ self ].
	self dispatchEvent: BlLayoutResizerChangedEvent new.
	self requestLayout
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self resizerDo: [ :c |
			(self isVExact: aNumber)  ifFalse: [
				c vertical exact: aNumber ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vExactOrFitContent [

	self isVExact ifFalse: [ self vFitContent ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vFitContent [

	self resizerDo: [ :c |
		self isVFitContent ifFalse: [ c vertical fitContent ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vFitContentLimited [

	self resizerDo: [ :c |
		self isVFitContentLimited ifFalse: [ c vertical fitContentLimited ] ]
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vFitElement: anElement [

	anElement isVMatchParent ifTrue: [ ^ self vMatchParent ].
	self vFitContent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vFitParent: anElement [

	anElement isVFitContent ifTrue: [ ^ self vFitContent ].
	self vMatchParent
]

{ #category : #'t - layout resizable' }
TBlLayoutResizable >> vMatchParent [

	self resizerDo: [ :c |
		self isVMatchParent ifFalse: [ c vertical matchParent ] ]
]
