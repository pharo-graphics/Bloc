"
I define examples for the class ${class:BlChildrenLinkedList}$.

Instances of ${class:BlChildrenLinkedList}$ are created by directly instatiating the class.
${example:BlChildrenLinkedListExamples>>#emptyChildrenExplicitCreation}$

Bloc elements can then be added and removed from the collection.
${example:BlChildrenLinkedListExamples>>#add}$

${example:BlChildrenLinkedListExamples>>#remove}$
"
Class {
	#name : #BlChildrenLinkedListExamplesMigrated,
	#superclass : #Object,
	#traits : 'TBlChildrenExamplesMigrated',
	#classTraits : 'TBlChildrenExamplesMigrated classTrait',
	#category : #'Bloc-Examples-ChildrenMigrated'
}

{ #category : #'examples - children' }
BlChildrenLinkedListExamplesMigrated >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenLinkedList new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenLinkedListExamplesMigrated >> newChildrenCollection [
	^ BlChildrenLinkedList new
]
