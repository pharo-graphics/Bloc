Class {
	#name : #BlDemoData,
	#superclass : #Object,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElement [

	<sampleInstance>
	^ BlElement new background: Color blue
]

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElement2 [

	<sampleInstance>
	^ BlElement new background: Color red
]

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElementWithADifferentPragma [

	<sampleInstance2>
	^ BlElement new background: Color blue
]
