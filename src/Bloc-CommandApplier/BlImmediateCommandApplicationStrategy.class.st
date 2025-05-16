Class {
	#name : #BlImmediateCommandApplicationStrategy,
	#superclass : #BlCommandApplicationStrategy,
	#category : #'Bloc-CommandApplier'
}

{ #category : #accessing }
BlImmediateCommandApplicationStrategy >> addCommand: aCommand from: aCommandApplier [

	aCommandApplier applyCommand: aCommand
]
