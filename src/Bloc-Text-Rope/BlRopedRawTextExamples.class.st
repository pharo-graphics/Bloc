Class {
	#name : #BlRopedRawTextExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Rope-Examples'
}

{ #category : #examples }
BlRopedRawTextExamples >> normalizedWithAttributes [
	<gtExample>
	| rawRope normalized |

	rawRope := BlRopedRawText string: ('Hello', String crlf, 'World').
	rawRope attributes: { BlTextForegroundAttribute paint: Color red } from: 3 to: 9.
	self assert: rawRope size equals: 12.
	#(2 10) do: [ :i |
		self assert: (rawRope attributesAt: i) isEmpty ].
	(3 to: 9) do: [ :i |
		self assert: (rawRope attributesAt: i) size equals: 1 ].

	normalized := rawRope normalized.
	self assert: normalized size equals: 11.
	#(2 9) do: [ :i |
		self assert: (normalized attributesAt: i) isEmpty ].
	(3 to: 8) do: [ :i |
		self assert: (normalized attributesAt: i) size equals: 1 ].

]
