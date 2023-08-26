Trait {
	#name : #TBlLayoutResizable,
	#category : #'Bloc-Layout-Resizer'
}

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> exact: aPoint [
	| aSize |
	
	aSize := aPoint asPoint.
	self hExact: aSize x.
	self vExact: aSize y
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> fitContent [
	self hFitContent.
	self vFitContent
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> fitContentLimited [
	self hFitContentLimited.
	self vFitContentLimited
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hExact: aNumber [

	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints horizontal resizer isExact
		and: [ self constraints horizontal resizer size = aNumber ])
			ifFalse: [ self constraintsDo: [ :c | c horizontal exact: aNumber ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hFitContent [

	(self constraints horizontal resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hFitContentLimited [
	(self constraints horizontal resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c horizontal fitContentLimited ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> hMatchParent [
	(self constraints horizontal resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c horizontal matchParent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> matchParent [
	self hMatchParent.
	self vMatchParent
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vExact: aNumber [
	
	"we have to set the size in the constraints because the resizer state is stateless and does not propagate the actual size value"
	(self constraints vertical resizer isExact
		and: [ self constraints vertical resizer size = aNumber ])
			ifFalse: [
				self constraintsDo: [ :c | c vertical exact: aNumber ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vFitContent [
	(self constraints vertical resizer isFitContent)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContent ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vFitContentLimited [
	(self constraints vertical resizer isFitContentLimited)
		ifFalse: [ self constraintsDo: [ :c | c vertical fitContentLimited ] ]
]

{ #category : #'t  - layout resizeable' }
TBlLayoutResizable >> vMatchParent [
	(self constraints vertical resizer isMatchParent)
		ifFalse: [ self constraintsDo: [ :c | c vertical matchParent ] ]
]
