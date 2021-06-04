"
I define examples for the class {{gtClass:BlChildrenLinkedList}}.

Instances of {{gtClass:BlChildrenLinkedList}} are created by directly instatiating the class.
{{gtExample:BlChildrenLinkedListExamples>>#emptyChildrenExplicitCreation}}

Bloc elements can then be added and removed from the collection.
{{gtExample:BlChildrenLinkedListExamples>>#add}}

{{gtExample:BlChildrenLinkedListExamples>>#remove}}

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
