"
I am helper builder class used to create composite ===BlKeyCombination===

Public API and Key Messages

- build finish combination creation and return result
- control add compulsory control key combination that alternatively matches both left and right control keys
- shift analog to control but adds shift
- meta analog to control but adds meta
- key: add compulsory combination consisting of a single Key
(advanced) cnf - resulting formula will be transformed to CNF (default)(https://en.wikipedia.org/wiki/Conjunctive_normal_form)
(advanced) dnf - resulting formula will be transformed to DNF (https://en.wikipedia.org/wiki/Disjunctive_normal_form)

Example:

   BlKeyCombinationBuilder new
	meta;
	shift;
	key: Key arrowUp;
	build
"
Class {
	#name : #BlKeyCombinationBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'combination',
		'converter'
	],
	#category : 'Bloc-KeyBinding'
}

{ #category : #accessing }
BlKeyCombinationBuilder >> alt [
	| alt |

	alt := BlAlternativeCombination new
		key: Key leftAlt;
		key: Key rightAlt;
		yourself.

	combination
		with: alt
]

{ #category : #accessing }
BlKeyCombinationBuilder >> backspace [
	combination
		with: (BlSingleKeyCombination new key: Key backspace)
]

{ #category : #builder }
BlKeyCombinationBuilder >> build [
	^ self toNormalForm: combination
]

{ #category : #builder }
BlKeyCombinationBuilder >> cnf [
	converter := BlKeyCombinationConverterCNF new
]

{ #category : #accessing }
BlKeyCombinationBuilder >> control [
	| control |

	control := BlAlternativeCombination new
		key: Key leftControl;
		key: Key rightControl;
		yourself.

	combination
		with: control
]

{ #category : #accessing }
BlKeyCombinationBuilder >> delete [
	combination
		with: (BlSingleKeyCombination new key: Key delete)
]

{ #category : #builder }
BlKeyCombinationBuilder >> dnf [
	converter := BlKeyCombinationConverterDNF new
]

{ #category : #accessing }
BlKeyCombinationBuilder >> escape [
	combination
		with: (BlSingleKeyCombination new key: Key escape)
]

{ #category : #initialization }
BlKeyCombinationBuilder >> initialize [
	super initialize.
	
	combination := BlCompulsoryCombination new.
	converter := BlKeyCombinationConverterCNF new
]

{ #category : #accessing }
BlKeyCombinationBuilder >> key: aKey [

	combination
		with: (BlSingleKeyCombination new key: aKey)
]

{ #category : #accessing }
BlKeyCombinationBuilder >> meta [
	| meta |

	meta := BlAlternativeCombination new
		key: Key leftMeta;
		key: Key rightMeta;
		yourself.

	combination
		with: meta
]

{ #category : #accessing }
BlKeyCombinationBuilder >> primary [
	"I add a primary modifier to the key combination
	On Mac: Command (Meta).
	On Windows: Control
	On Linux: Control"
	
	combination with: OSPlatform current primaryModifier
]

{ #category : #accessing }
BlKeyCombinationBuilder >> return [
	combination
		with: (BlSingleKeyCombination new key: Key return)
]

{ #category : #accessing }
BlKeyCombinationBuilder >> secondary [
	"I add a secondary modifier to the key combination
	On Mac: Control (Meta).
	On Windows: Alt
	On Linux: Alt"

	combination with: OSPlatform current secondaryModifier
]

{ #category : #accessing }
BlKeyCombinationBuilder >> shift [
	| shift |

	shift := BlAlternativeCombination new
		key: Key leftShift;
		key: Key rightShift;
		yourself.
		
	combination
		with: shift
]

{ #category : #private }
BlKeyCombinationBuilder >> toNormalForm: aKeyCombination [
	"Converts a given key combination to a normal form (CNF or DNF)
	(https://en.wikipedia.org/wiki/Conjunctive_normal_form)
	(https://en.wikipedia.org/wiki/Disjunctive_normal_form)"
	<return: #BlKeyCombination>

	^ aKeyCombination accept: converter
]
