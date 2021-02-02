Extension { #name : #OSWindowDriver }

{ #category : #'*BlocHost-OSWindow' }
OSWindowDriver class >> current: aDriver [
	Current := aDriver
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowDriver class >> isRunning [
	"Return true if oswindow driver exists, false otherwise"
	<return: #Boolean>

	^ Current isNotNil and: [ Session == Smalltalk session ]
]

{ #category : #'*BlocHost-OSWindow' }
OSWindowDriver >> reset [
	Current := nil
]
