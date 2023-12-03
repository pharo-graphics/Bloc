Extension { #name : #OSBackendWindow }

{ #category : #'*BlocHost-OSWindow' }
OSBackendWindow >> canvasExtent [
	^ renderer canvasExtent
]

{ #category : #'*BlocHost-OSWindow' }
OSBackendWindow >> fullscreen [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSBackendWindow >> maximized [
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSBackendWindow >> minimized [
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSBackendWindow >> newBlocRenderer [
	^ self subclassResponsibility
]
