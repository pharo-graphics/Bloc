Class {
	#name : #BlDevScripterMultipleActionStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterActionStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterActionStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter-Steps'
}
