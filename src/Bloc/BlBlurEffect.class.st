Class {
	#name : #BlBlurEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'radius'
	],
	#category : #'Bloc-Effect'
}

{ #category : #accessing }
BlBlurEffect class >> radius: aNumber [
	^ self new
		radius: aNumber;
		yourself
]

{ #category : #accessing }
BlBlurEffect >> radius [
	^ radius
]

{ #category : #accessing }
BlBlurEffect >> radius: aNumber [
	"Set standart deviation of gaussian blur"
	radius := aNumber
]
