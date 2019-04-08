Extension { #name : #OSWindowHandle }

{ #category : #'*BlocHost-OSWindow' }
OSWindowHandle >> canvasExtent [
	^ renderer canvasExtent
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowHandle >> fullscreen [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowHandle >> maximized [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowHandle >> minimized [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowHandle >> newBlocRenderer [
	^ self subclassResponsibility
]
