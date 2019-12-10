Class {
	#name : #BlDevScripterMultipleActionStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterActionStep - {#addStep:}',
	#classTraits : 'TBlDevScripterActionStep classTrait',
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #'steps - storing' }
BlDevScripterMultipleActionStep >> storeAt: aSymbol elementInfo: anOneArgBlock [
	^ self addStep: (BlDevScripterStoreElementInfoStep new
		key: aSymbol;
		block: anOneArgBlock)
]

{ #category : #'steps - subactions' }
BlDevScripterMultipleActionStep >> substep [
	^ self addStep: (BlDevScripterMultipleActionStep new)
]
