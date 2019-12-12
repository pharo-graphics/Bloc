Class {
	#name : #BlDevScripterReference,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter-References'
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
