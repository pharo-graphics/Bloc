"
I am a task that executes a valuable (such as a block closure) once during a space pulse.

I can be created using the convenience constructor:

```smalltalk
BlTaskAction with: [ :optionalThisTask | ... ]
```

When executed, I evaluate my action valuable (culling myself if the valuable accepts an argument).
"
Class {
	#name : #BlTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlTaskAction class >> new [

	^ self with: [ :optionalThisTask |  ]
]

{ #category : #'instance creation' }
BlTaskAction class >> with: aValuable [

	^ self basicNew
		initializeWithAction: aValuable;
		yourself
]

{ #category : #accessing }
BlTaskAction >> action [

	^ action
]

{ #category : #accessing }
BlTaskAction >> action: aValuable [

	action := aValuable
]

{ #category : #initialization }
BlTaskAction >> initializeWithAction: aValuable [

	self initialize.

	action := aValuable
]

{ #category : #printing }
BlTaskAction >> printOn: aStream [

	aStream
		print: self className;
		space;
		nextPut: $(;
		print: action;
		nextPut: $)
]

{ #category : #'api - running' }
BlTaskAction >> run [

	action isClosure
		ifTrue: [ action cull: self ]
		ifFalse: [ action value ]
]
