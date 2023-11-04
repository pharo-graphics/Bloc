Class {
	#name : #BlTextDecorationType,
	#superclass : #Object,
	#category : 'Bloc-Text-Text-Decoration'
}

{ #category : #testing }
BlTextDecorationType class >> isAbstract [
	^ self = BlTextDecorationType
]

{ #category : #accessing }
BlTextDecorationType class >> lineThrough [
	^ BlTextDecorationLineThroughType uniqueInstance
]

{ #category : #accessing }
BlTextDecorationType class >> overline [
	^ BlTextDecorationOverlineType uniqueInstance
]

{ #category : #accessing }
BlTextDecorationType class >> underline [
	^ BlTextDecorationUnderlineType uniqueInstance
]

{ #category : #enumerating }
BlTextDecorationType >> typesDo: aBlock [
	
]

{ #category : #'logical operations' }
BlTextDecorationType >> | anOtherDecorationType [
	^ self subclassResponsibility
]
