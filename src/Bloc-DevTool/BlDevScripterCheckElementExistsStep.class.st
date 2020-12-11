Class {
	#name : #BlDevScripterCheckElementExistsStep,
	#superclass : #BlDevScripterCheckStep,
	#instVars : [
		'elementId'
	],
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterCheckElementExistsStep >> playOn: aScripter [
	| anElement |

	anElement := [ self target findTargetStartingInScripter: aScripter] on: Error do: [ nil ].
	self 
		assert: [ anElement notNil ]
		description: [ 'Element should exist' ].
]
