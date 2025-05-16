Class {
	#name : #BlCommandApplicationStrategy,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	self subclassResponsibility 
]

{ #category : #accessing }
BlCommandApplicationStrategy >> element: anElement [

	element := anElement
]
