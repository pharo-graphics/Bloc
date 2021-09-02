Class {
	#name : 'BlDevScripterCheckElementExistsStep',
	#superclass : 'BlDevScripterCheckStep',
	#category : 'Bloc-Scripter-Scripter-Steps'
}

{ #category : 'actions' }
BlDevScripterCheckElementExistsStep >> playOn: aScripter [
	| anElement |

	anElement := [ self target findTargetStartingInScripter: aScripter] on: Error do: [ nil ].
	self 
		assert: [ anElement notNil ]
		description: [ 'Element should exist' ].
]
