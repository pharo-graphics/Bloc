Class {
	#name : #BlDevScripterSelfEventTarget,
	#superclass : #BlDevScripterEventTarget,
	#category : #'Bloc-Scripter-Scripter-Targets'
}

{ #category : #searching }
BlDevScripterSelfEventTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ anElement
]

{ #category : #accessing }
BlDevScripterSelfEventTarget >> identifier [
	^ 'self'
]

{ #category : #printing }
BlDevScripterSelfEventTarget >> printOn: aStream [
	aStream nextPutAll: 'self'
]

{ #category : #updating }
BlDevScripterSelfEventTarget >> updateUsing: aScripterEventTarget on: aStep [
	aStep target: aScripterEventTarget
	
]
