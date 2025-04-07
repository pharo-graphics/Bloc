"
I am a Layout decorator that makes other layouts to be computed only once.

Example:

```
	| aLayout |	
	
	aLayout := BlOnceLayout on: BlGridLayout new.
	aLayout isStopped. ""false""
	"".... after layout is done....""
	aLayout isStopped. ""true""
```

"
Class {
	#name : #BlOnceLayout,
	#superclass : #BlLayout,
	#instVars : [
		'layout',
		'isStopped',
		'measuredExtent'
	],
	#category : #'Bloc-Layout-Once'
}

{ #category : #'instance creation' }
BlOnceLayout class >> on: aBlLayout [
	<return: #BlOnceLayout>

	^ self new layout: aBlLayout
]

{ #category : #initialization }
BlOnceLayout >> initialize [
	super initialize.

	isStopped := false.
	layout := BlBasicLayout uniqueInstance
]

{ #category : #accessing }
BlOnceLayout >> isStopped [
	^ isStopped
]

{ #category : #accessing }
BlOnceLayout >> isStopped: aBoolean [
	isStopped := aBoolean
]

{ #category : #accessing }
BlOnceLayout >> layout [
	^ layout
]

{ #category : #accessing }
BlOnceLayout >> layout: aBlLayout [
	layout := aBlLayout
]

{ #category : #layout }
BlOnceLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	self isStopped
		ifFalse: [ ^ self layout layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext ].
		
	anElement children accountedByLayout do: [ :child |
		| childLayoutBounds |
		childLayoutBounds := child constraints position extent: child measuredExtent.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdateContext ].

	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext
]

{ #category : #measure }
BlOnceLayout >> measure: anElement with: anExtentSpec [

	self isStopped ifFalse: [
		^ self layout measure: anElement with: anExtentSpec ].

	super
		measure: anElement
		with: (BlExtentMeasurementSpec exact: measuredExtent).
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #'hooks - layout' }
BlOnceLayout >> onLayoutDone: anElement [
	super onLayoutDone: anElement.
	
	isStopped := true.
	anElement childrenDo: [ :aChildElement |
		aChildElement constraints position: aChildElement position.
		
		aChildElement constraints horizontal resizer isFitContent
			ifFalse: [ aChildElement constraints horizontal exact: aChildElement width ].
			
		aChildElement constraints vertical resizer isFitContent
			ifFalse: [ aChildElement constraints vertical exact: aChildElement height ] ].
	measuredExtent := anElement extent
]
