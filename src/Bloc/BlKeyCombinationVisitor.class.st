"
I am a visitor for `=BlKeyCombination`= composition tree.
See my subclasses for all available visitors.

Example:

	result := keyCombination accept: visitor

"
Class {
	#name : 'BlKeyCombinationVisitor',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : 'visiting' }
BlKeyCombinationVisitor >> visitAlternative: aBlAlternativeCombination [
]

{ #category : 'visiting' }
BlKeyCombinationVisitor >> visitCompulsory: aBlCompulsoryCombination [
]

{ #category : 'visiting' }
BlKeyCombinationVisitor >> visitKey: aBlKeyCodeCombination [
]
