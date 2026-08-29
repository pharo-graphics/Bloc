Class {
	#name : #BlDevScripterKeyUpStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyUpStep >> defaultLabel [
	^ 'Key up'
]

{ #category : #actions }
BlDevScripterKeyUpStep >> playOn: aScripter [
	| aTarget |

	aTarget := self target findTargetStartingInScripter: aScripter.
	aTarget eventSimulator keyUp: self key.
	aScripter settle
]
