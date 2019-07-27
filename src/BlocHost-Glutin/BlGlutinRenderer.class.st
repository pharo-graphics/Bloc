Class {
	#name : #BlGlutinRenderer,
	#superclass : #Object,
	#instVars : [
		'hostSpace'
	],
	#category : #'BlocHost-Glutin'
}

{ #category : #accessing }
BlGlutinRenderer >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlGlutinRenderer >> hostSpace: anObject [
	hostSpace := anObject
]

{ #category : #'private - gl' }
BlGlutinRenderer >> makeCurrent [
	self window isValid
		ifFalse: [ ^ self ].
	
	self window makeCurrent
]

{ #category : #'private - gl' }
BlGlutinRenderer >> swapBuffers [
	self window swapBuffers
]

{ #category : #accessing }
BlGlutinRenderer >> window [
	^ self hostSpace window
]
