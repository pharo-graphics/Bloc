Class {
	#name : #BlDevScripterCheckTask,
	#superclass : #BlDevScripterTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #actions }
BlDevScripterCheckTask >> playOn: aScripter [
	self validateOn: aScripter element
]

{ #category : #actions }
BlDevScripterCheckTask >> validateOn: anElement [

]
