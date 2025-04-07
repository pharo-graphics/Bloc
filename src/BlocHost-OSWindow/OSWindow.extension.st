Extension { #name : #OSWindow }

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> canvasExtent [
	^ self validHandle canvasExtent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindow >> center [
	"Tell backend to center window on screen."

	^ self validHandle center
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
OSWindow >> newBlocRenderer [
	^ self validHandle newBlocRenderer
]
