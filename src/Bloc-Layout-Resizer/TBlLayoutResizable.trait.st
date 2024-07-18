Trait {
	#name : #TBlLayoutResizable,
	#category : #'Bloc-Layout-Resizer'
}

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> exact: aPoint [

	self resizerDo: [ :c | self requestExact: aPoint on: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> fitContent [

	self resizerDo: [ :c | self requestFitContentOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> fitContentLimited [

	self resizerDo: [ :c |
		self requestFitContentLimitedOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> hExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self resizerDo: [ :c | self requestHExact: aNumber on: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> hFitContent [

	self resizerDo: [ :c | self requestHFitContentOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> hFitContentLimited [

	self resizerDo: [ :c | self requestHFitContentLimitedOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> hMatchParent [

	self resizerDo: [ :c | self requestHMatchParentOn: c ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isExact [

	^ self isHExact and: [ self isVExact ]
]

{ #category : #'t - layout resizable - testing' }
TBlLayoutResizable >> isHExact [

	^ self constraints horizontal resizer isExact
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

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> matchParent [

	self resizerDo: [ :c | self requestMatchParentOn: c ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestExact: aPoint on: aConstraints [

	| aSize |
	aSize := aPoint asPoint.
	(aConstraints horizontal resizer isExact and: [
		 aConstraints horizontal resizer size = aSize x ]) ifFalse: [
		aConstraints horizontal exact: aSize x ].
	(aConstraints vertical resizer isExact and: [
		 aConstraints vertical resizer size = aSize y ]) ifFalse: [
		aConstraints vertical exact: aSize y ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestFitContentLimitedOn: aConstraints [

	(aConstraints horizontal resizer isFitContentLimited and: [
		 aConstraints vertical resizer isFitContentLimited ]) ifTrue: [
		^ self ].
	aConstraints horizontal fitContentLimited.
	aConstraints vertical fitContentLimited
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestFitContentOn: aConstraints [

	(aConstraints horizontal resizer isFitContent and: [
		 aConstraints vertical resizer isFitContent ]) ifTrue: [
		^ self ].
	aConstraints horizontal fitContent.
	aConstraints vertical fitContent
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestHExact: aNumber on: aConstraints [

	(aConstraints horizontal resizer isExact and: [
		 aConstraints horizontal resizer size = aNumber ]) ifFalse: [
		aConstraints horizontal exact: aNumber ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestHFitContentLimitedOn: aConstraints [

	aConstraints horizontal resizer isFitContentLimited ifFalse: [
		aConstraints horizontal fitContentLimited ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestHFitContentOn: aConstraints [

	aConstraints horizontal resizer isFitContent ifFalse: [
		aConstraints horizontal fitContent ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestHMatchParentOn: aConstraints [

	aConstraints horizontal resizer isMatchParent ifFalse: [
		aConstraints horizontal matchParent ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestMatchParentOn: aConstraint [

	self requestHMatchParentOn: aConstraint.
	self requestVMatchParentOn: aConstraint
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestVExact: aNumber on: aConstraints [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	(aConstraints vertical resizer isExact and: [
		 aConstraints vertical resizer size = aNumber ]) ifFalse: [
		aConstraints vertical exact: aNumber ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestVFitContentLimitedOn: aConstraints [

	aConstraints vertical resizer isFitContentLimited ifFalse: [
		aConstraints vertical fitContentLimited ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestVFitContentOn: aConstraints [

	aConstraints vertical resizer isFitContent ifFalse: [
		aConstraints vertical fitContent ]
]

{ #category : #'t - layout resizeable - request' }
TBlLayoutResizable >> requestVMatchParentOn: aConstraints [

	aConstraints vertical resizer isMatchParent ifFalse: [
		aConstraints vertical matchParent ]
]

{ #category : #'t - layout resizeable' }
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

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> vExact: aNumber [
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"

	self resizerDo: [ :c | self requestVExact: aNumber on: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> vFitContent [

	self resizerDo: [ :c | self requestVFitContentOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> vFitContentLimited [

	self resizerDo: [ :c | self requestVFitContentLimitedOn: c ]
]

{ #category : #'t - layout resizeable' }
TBlLayoutResizable >> vMatchParent [

	self resizerDo: [ :c | self requestVMatchParentOn: c ]
]
