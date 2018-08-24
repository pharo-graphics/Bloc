Class {
	#name : #BlExampleSwitchController,
	#superclass : #BlElementEventListener,
	#category : 'Bloc-Examples-Widgets'
}

{ #category : #'mouse handlers' }
BlExampleSwitchController >> clickEvent: anEvent [
	anEvent consumed: true.
	
	anEvent currentTarget activated: anEvent currentTarget isActivated not
]
