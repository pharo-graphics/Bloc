Class {
	#name : 'BlDevScripterEventProcessorTarget',
	#superclass : 'BlDevScripterTarget',
	#category : 'Bloc-Scripter-Scripter-Targets',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Targets'
}

{ #category : 'testing' }
BlDevScripterEventProcessorTarget class >> isAbstract [
	^ self name = #BlDevScripterEventProcessorTarget
]

{ #category : 'searching' }
BlDevScripterEventProcessorTarget >> findTargetIn: anElement [
	<return: #BlElement>
	self 
		assert: [ anElement isAttachedToSceneGraph ]
		description: [ 'Element must be in space' ].

	^ self findTargetStartingInSpace: anElement space
]

{ #category : 'searching' }
BlDevScripterEventProcessorTarget >> findTargetStartingInScripter: aScripter [
	^ self findTargetStartingInSpace: aScripter space
]

{ #category : 'searching' }
BlDevScripterEventProcessorTarget >> findTargetStartingInSpace: aSpace [
	^ self subclassResponsibility
]
