Class {
	#name : #BlElementDynamicProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'applyAction',
		'cleanAction'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : #accessing }
BlElementDynamicProperty >> applyAction [
	^ applyAction
]

{ #category : #accessing }
BlElementDynamicProperty >> applyAction: anObject [
	applyAction := anObject
]

{ #category : #'api - property' }
BlElementDynamicProperty >> applyOnElement: anElement [
	self applyAction cull: anElement
]

{ #category : #accessing }
BlElementDynamicProperty >> cleanAction [
	^ cleanAction
]

{ #category : #accessing }
BlElementDynamicProperty >> cleanAction: anObject [
	cleanAction := anObject
]

{ #category : #'api - property' }
BlElementDynamicProperty >> cleanUpOnElement: anElement [
	self cleanAction cull: anElement
]

{ #category : #initialization }
BlElementDynamicProperty >> initialize [
	super initialize.
	
	applyAction := [ :anElement | ].
	cleanAction := [ :anElement | ]
]

{ #category : #generated }
BlElementDynamicProperty >> type [
	^ { self applyAction . self cleanAction }
]
