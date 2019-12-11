Class {
	#name : #BlDevScripterTarget,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter-Targets'
}

{ #category : #factory }
BlDevScripterTarget class >> null [
	^ BlDevScripterNullTarget uniqueInstance
]

{ #category : #searching }
BlDevScripterTarget >> findTargetIn: anElement [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #searching }
BlDevScripterTarget >> findTargetStartingInScripter: aScripter [
	^ self findTargetIn: aScripter element
]

{ #category : #accessing }
BlDevScripterTarget >> identifier [
	^ self className
]

{ #category : #updating }
BlDevScripterTarget >> updateUsing: aScripterEventTarget on: aStep [
	aStep target: aScripterEventTarget
]
