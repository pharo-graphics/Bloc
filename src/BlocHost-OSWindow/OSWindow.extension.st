Extension { #name : #OSWindow }

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> canvasExtent [
	^ self validHandle canvasExtent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> fullscreen [
	^ self validHandle fullscreen
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> maximized [
	^ self validHandle maximized
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> minimized [
	^ self validHandle minimized
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> windowExtent [
	^ self extent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> windowExtent: aPoint [
	self extent: aPoint
]
