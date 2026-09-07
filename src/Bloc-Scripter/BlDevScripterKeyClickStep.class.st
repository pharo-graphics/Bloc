Class {
	#name : #BlDevScripterKeyClickStep,
	#superclass : #BlDevScripterKeyboardStep,
	#category : #'Bloc-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyClickStep >> defaultLabel [
	^ 'Key press'
]

{ #category : #actions }
BlDevScripterKeyClickStep >> playOn: aScripter [
	| aTarget |

	aTarget := self target findTargetStartingInScripter: aScripter.
	aTarget eventSimulator keyPress: self key.
	aScripter settle
]
