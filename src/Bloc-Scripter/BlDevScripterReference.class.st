Class {
	#name : #BlDevScripterReference,
	#superclass : #BlDevScripterStepProperty,
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #factory }
BlDevScripterReference class >> method: aRGMethorDefinition [
	^ BlDevScripterMethodReference new definition: aRGMethorDefinition
]

{ #category : #factory }
BlDevScripterReference class >> null [
	^ BlDevScripterNoReference uniqueInstance
]

{ #category : #enumerating }
BlDevScripterReference >> definitionDo: aBlock [
]

{ #category : #'gt-extension' }
BlDevScripterReference >> gtReferenceFor: aView [
	^ aView empty
]

{ #category : #testing }
BlDevScripterReference >> isReference [

	^ true
]
