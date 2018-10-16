"
I define examples for the class ${class:BlChildrenRope}$.

Instances of ${class:BlChildrenRope}$ are created by directly instatiating the class.
${example:BlChildrenRopeExamples>>#emptyChildrenExplicitCreation}$

Bloc elements can then be added and removed from the collection.
${example:BlChildrenRopeExamples>>#add}$

${example:BlChildrenRopeExamples>>#remove}$
"
Class {
	#name : #BlChildrenRopeExamples,
	#superclass : #Object,
	#traits : 'TBlChildrenExample',
	#classTraits : 'TBlChildrenExample classTrait',
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - children' }
BlChildrenRopeExamples >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenRope new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenRopeExamples >> newChildrenCollection [
	^ BlChildrenRope new
]
