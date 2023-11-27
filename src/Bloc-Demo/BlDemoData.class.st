Class {
	#name : #BlDemoData,
	#superclass : #Object,
	#category : #'Bloc-Demo-NodeTests'
}

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElement [

	<demo>
	^ BlElement new background: Color blue
]

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElement2 [

	<demo>
	^ BlElement new background: Color red
]

{ #category : #'as yet unclassified' }
BlDemoData >> returnBlElementWithADifferentPragma [

	<demo2>
	^ BlElement new background: Color blue
]
