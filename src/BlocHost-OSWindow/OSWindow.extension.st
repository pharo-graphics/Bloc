Extension { #name : #OSWindow }

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> canvasExtent [
	^ self validHandle canvasExtent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> windowExtent [
	^ self extent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> windowExtent: aPoint [
	self extent: aPoint
]
