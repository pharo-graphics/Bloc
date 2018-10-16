"
I define examples for the class ${class:BlChildrenLinkedList}$.

Instances of ${class:BlChildrenLinkedList}$ are created by directly instatiating the class.
${example:BlChildrenLinkedListExamples>>#emptyChildrenExplicitCreation}$

Bloc elements can then be added and removed from the collection.
${example:BlChildrenLinkedListExamples>>#add}$

${example:BlChildrenLinkedListExamples>>#remove}$
"
Class {
	#name : #BlChildrenLinkedListExamples,
	#superclass : #Object,
	#traits : 'TBlChildrenExample',
	#classTraits : 'TBlChildrenExample classTrait',
	#category : #'Bloc-Examples-Children'
}

{ #category : #'examples - children' }
BlChildrenLinkedListExamples >> emptyChildrenExplicitCreation [
	<gtExample>
	| theChildren |

	theChildren := BlChildrenLinkedList new.
	self assert: theChildren size equals: 0.
	self assert: theChildren isEmpty.
	self assert: theChildren isNotEmpty not.

	^ theChildren
]

{ #category : #'instance creation' }
BlChildrenLinkedListExamples >> newChildrenCollection [
	^ BlChildrenLinkedList new
]
