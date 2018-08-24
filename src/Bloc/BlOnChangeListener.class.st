"
I am a scriptable version of my parent.
You can use my class method #do:[:newValue|] to define your own action as a block.
"
Class {
	#name : #BlOnChangeListener,
	#superclass : #BlChangeListener,
	#instVars : [
		'action'
	],
	#category : 'Bloc-Property'
}

{ #category : #'as yet unclassified' }
BlOnChangeListener class >> do: aBlock [
	^ self new
		action: aBlock;
		yourself
]

{ #category : #accessing }
BlOnChangeListener >> action [
	<return: #BlockClosure>

	^ action
]

{ #category : #accessing }
BlOnChangeListener >> action: aBlock [
	action := aBlock
]

{ #category : #changes }
BlOnChangeListener >> valueChanged: aValue [
	self action cull: aValue
]
