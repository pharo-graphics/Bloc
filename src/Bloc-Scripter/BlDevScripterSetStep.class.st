Class {
	#name : 'BlDevScripterSetStep',
	#superclass : 'BlDevScripterTargetedStep',
	#instVars : [
		'storage'
	],
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterSetStep >> defaultLabel [
	^ self storage 
		ifNil: [ 'Set' ]
		ifNotNil: [ :aStorage | aStorage printString ]
]

{ #category : 'initialization' }
BlDevScripterSetStep >> defaultTarget [
	^ BlDevScripterAsTarget new
]

{ #category : 'accessing' }
BlDevScripterSetStep >> element: anOneArgBlock [
	self storage: (BlDevScripterElementStorage new block: anOneArgBlock)
]

{ #category : 'accessing' }
BlDevScripterSetStep >> key: aKeyBlock value: aValueBlock [
	self storage: (BlDevScripterUserDataStorage new key: aKeyBlock; value: aValueBlock)
]

{ #category : 'accessing' }
BlDevScripterSetStep >> model: anOneArgBlock [
	self storage: (BlDevScripterModelStorage new block: anOneArgBlock)
]

{ #category : 'actions' }
BlDevScripterSetStep >> playOn: aScripter [
	"Where do we get an information"
	| aTarget |
	aTarget := self target findTargetStartingInScripter: aScripter.
	self storage storeFrom: aTarget scripter: aScripter.
]

{ #category : 'accessing' }
BlDevScripterSetStep >> storage [
	^ storage
]

{ #category : 'accessing' }
BlDevScripterSetStep >> storage: anObject [
	storage := anObject
]
