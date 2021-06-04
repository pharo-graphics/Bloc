"
I represent layout constraints and I am a superclass of all layout constraints.

Layouts that require additional properties must subclass be and add an extension method to `=BlLayoutCommonConstraints`=

Since some constraints are also axis dependent (horizontal or vertical) I provide access to them through #horizontal and #vertical.

See `=BlLayoutConstraintsAxis`= to learn more about axis-dependent constraints

"
Class {
	#name : #BlLayoutConstraints,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'vertical',
		'horizontal'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #initialization }
BlLayoutConstraints >> defaultHorizontal [
	^ BlLayoutConstraintsAxis new
]

{ #category : #initialization }
BlLayoutConstraints >> defaultVertical [
	^ BlLayoutConstraintsAxis new
]

{ #category : #accessing }
BlLayoutConstraints >> horizontal [
	"Return horizontal-axis specific constraints.
	horizontal constraints can not be nil"
	<return: #BlLayoutConstraintsAxis>

	^ horizontal
]

{ #category : #initialization }
BlLayoutConstraints >> initialize [
	super initialize.
	
	horizontal := self defaultHorizontal.
	vertical := self defaultVertical
]

{ #category : #accessing }
BlLayoutConstraints >> vertical [
	"Return vertical-axis specific constraints.
	vertical constraints can not be nil"
	<return: #BlLayoutConstraintsAxis>

	^ vertical
]
