Class {
	#name : #BlDevScripterCheckElementNotExistsStep,
	#superclass : #BlDevScripterCheckStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterCheckElementNotExistsStep >> playOn: aScripter [
	| anElement |

	anElement := [ self target findTargetStartingInScripter: aScripter] on: Error do: [ nil ].
	self 
		assert: [ anElement isNil ]
		description: [ 'Element should not exist' ].
]
