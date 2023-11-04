Class {
	#name : #BlGridLayoutConstants,
	#superclass : #SharedPool,
	#classVars : [
		'UNDEFINED'
	],
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #'class initialization' }
BlGridLayoutConstants class >> initialize [
	super initialize.
	
	UNDEFINED := ((-2147483648) / 2 + 1) rounded
]
