"
I define examples for the class ${class:BlChildrenRope}$.

Instances of ${class:BlChildrenRope}$ are created by directly instatiating the class.
${example:BlChildrenRopeExamples>>#emptyChildrenExplicitCreation}$

Bloc elements can then be added and removed from the collection.
${example:BlChildrenRopeExamples>>#add}$

${example:BlChildrenRopeExamples>>#remove}$
"
Class {
	#name : #BlChildrenRopeExamplesMigrated,
	#superclass : #Object,
	#traits : 'TBlChildrenExamplesMigrated',
	#classTraits : 'TBlChildrenExamplesMigrated classTrait',
	#category : #'Bloc-Examples-ChildrenMigrated'
}

{ #category : #'examples - children' }
BlChildrenRopeExamplesMigrated >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenRope new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenRopeExamplesMigrated >> newChildrenCollection [
	^ BlChildrenRope new
]
