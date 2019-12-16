Class {
	#name : #BlDevScripterReference,
	#superclass : #BlDevScripterStepProperty,
	#category : #'Bloc-DevTool-Scripter-Properties'
}

{ #category : #factory }
BlDevScripterReference class >> method: aRGMethorDefinition [
	^ BlDevScripterMethodReference new definition: aRGMethorDefinition
]

{ #category : #factory }
BlDevScripterReference class >> null [
	^ BlDevScripterNoReference uniqueInstance
]

{ #category : #'gt-extension' }
BlDevScripterReference >> gtReferenceFor: aView [
	^ aView empty
]

{ #category : #testing }
BlDevScripterReference >> isReference [
	<return: #Boolean>
	^ true
]
