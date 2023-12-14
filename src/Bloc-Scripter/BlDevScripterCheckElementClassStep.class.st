Class {
	#name : 'BlDevScripterCheckElementClassStep',
	#superclass : 'BlDevScripterCheckStep',
	#instVars : [
		'elementClass'
	],
	#category : 'Bloc-Scripter-Scripter-Steps',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Steps'
}

{ #category : 'accessing' }
BlDevScripterCheckElementClassStep >> defaultLabel [
	^ 'Class: ', self elementClass asString
]

{ #category : 'accessing' }
BlDevScripterCheckElementClassStep >> elementClass [
	^ elementClass
]

{ #category : 'accessing' }
BlDevScripterCheckElementClassStep >> elementClass: anObject [
	elementClass := anObject
]

{ #category : 'actions' }
BlDevScripterCheckElementClassStep >> validateOn: anElement [
	self assert: self elementClass isNotNil.
	self assert: anElement class equals: self elementClass.
]
