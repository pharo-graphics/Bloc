"
I am helper builder class used to create composite `=BlKeyCombination`=

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
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> a [
	combination with: (BlSingleKeyCombination new key: KeyboardKey A)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> alt [
	| alt |

	alt := BlAlternativeCombination new
		key: KeyboardKey altLeft;
		key: KeyboardKey altRight;
		yourself.

	combination
		with: alt
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowDown [
	combination with: (BlSingleKeyCombination new key: KeyboardKey down)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowLeft [
	combination with: (BlSingleKeyCombination new key: KeyboardKey left)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowRight [
	combination with: (BlSingleKeyCombination new key: KeyboardKey right)
]

{ #category : #'keys - navigation' }
BlKeyCombinationBuilder >> arrowUp [
	combination with: (BlSingleKeyCombination new key: KeyboardKey up)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> b [
	combination with: (BlSingleKeyCombination new key: KeyboardKey B)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> backspace [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey backspace)
]

{ #category : #builder }
BlKeyCombinationBuilder >> build [
	^ self toNormalForm: combination
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> c [
	combination with: (BlSingleKeyCombination new key: KeyboardKey C)
]

{ #category : #builder }
BlKeyCombinationBuilder >> cnf [
	converter := BlKeyCombinationConverterCNF new
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> control [
	| control |

	control := BlAlternativeCombination new
		key: KeyboardKey controlLeft;
		key: KeyboardKey controlRight;
		yourself.

	combination
		with: control
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> d [
	combination with: (BlSingleKeyCombination new key: KeyboardKey D)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> delete [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey delete)
]

{ #category : #builder }
BlKeyCombinationBuilder >> dnf [
	converter := BlKeyCombinationConverterDNF new
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> e [
	combination with: (BlSingleKeyCombination new key: KeyboardKey E)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> end [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey end)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> equal [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey equal)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> escape [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey escape)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> f [
	combination with: (BlSingleKeyCombination new key: KeyboardKey F)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> g [
	combination with: (BlSingleKeyCombination new key: KeyboardKey G)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> home [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey home)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> i [
	combination with: (BlSingleKeyCombination new key: KeyboardKey I)
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

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> l [
	combination with: (BlSingleKeyCombination new key: KeyboardKey L)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> m [
	combination with: (BlSingleKeyCombination new key: KeyboardKey M)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> meta [
	| meta |

	meta := BlAlternativeCombination new
		key: KeyboardKey metaLeft;
		key: KeyboardKey metaRight;
		key: KeyboardKey superLeft;
		key: KeyboardKey superRight;
		yourself.

	combination
		with: meta
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> minus [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey minus)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> n [
	combination with: (BlSingleKeyCombination new key: KeyboardKey N)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> p [
	combination with: (BlSingleKeyCombination new key: KeyboardKey P)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> primary [
	"I add a primary modifier to the key combination
	On Mac: Command (Meta).
	On Windows: Control
	On Linux: Control"
	
	combination with: OSPlatform current primaryModifier
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> r [
	combination with: (BlSingleKeyCombination new key: KeyboardKey R)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> return [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey enter)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> s [
	combination with: (BlSingleKeyCombination new key: KeyboardKey S)
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> secondary [
	"I add a secondary modifier to the key combination
	On Mac: Control (Meta).
	On Windows: Alt
	On Linux: Alt"

	combination with: OSPlatform current secondaryModifier
]

{ #category : #'keys - modifiers' }
BlKeyCombinationBuilder >> shift [
	| shift |

	shift := BlAlternativeCombination new
		key: KeyboardKey shiftLeft;
		key: KeyboardKey shiftRight;
		yourself.
		
	combination
		with: shift
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> space [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey space)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> t [
	combination with: (BlSingleKeyCombination new key: KeyboardKey T)
]

{ #category : #'keys - special' }
BlKeyCombinationBuilder >> tab [
	combination
		with: (BlSingleKeyCombination new key: KeyboardKey tab)
]

{ #category : #private }
BlKeyCombinationBuilder >> toNormalForm: aKeyCombination [
	"Converts a given key combination to a normal form (CNF or DNF)
	(https://en.wikipedia.org/wiki/Conjunctive_normal_form)
	(https://en.wikipedia.org/wiki/Disjunctive_normal_form)"
	<return: #BlKeyCombination>

	^ aKeyCombination accept: converter
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> v [
	combination with: (BlSingleKeyCombination new key: KeyboardKey V)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> w [
	combination with: (BlSingleKeyCombination new key: KeyboardKey W)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> x [
	combination with: (BlSingleKeyCombination new key: KeyboardKey X)
]

{ #category : #'keys - letters' }
BlKeyCombinationBuilder >> z [
	combination with: (BlSingleKeyCombination new key: KeyboardKey Z)
]
