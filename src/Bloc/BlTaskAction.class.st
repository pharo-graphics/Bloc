Class {
	#name : #BlTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'action'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlTaskAction class >> with: aValuable [

	^ self new
		action: aValuable;
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
BlTaskAction >> initialize [

	super initialize.

	action := [ :optionalThisTask |  ]
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

{ #category : #running }
BlTaskAction >> run [

	action isClosure
		ifTrue: [ action cull: self ]
		ifFalse: [ action value ]
]
