Class {
	#name : #BlProcess,
	#superclass : #Process,
	#instVars : [
		'processAnnotation'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlProcess >> annotate: aTag with: aValue [
	self processAnnotation at: aTag put: aValue.
]

{ #category : #accessing }
BlProcess >> annotation: aTag [
	^ self processAnnotation at: aTag ifAbsent: [ nil ]
]

{ #category : #accessing }
BlProcess >> hasProcessAnnotations [
	^ processAnnotation notNil and: [ processAnnotation isNotEmpty ]
]

{ #category : #accessing }
BlProcess >> invocatedByElement [
	^ self task ifNotNil: #invocatedByElement
]

{ #category : #accessing }
BlProcess >> processAnnotation [
	^ processAnnotation ifNil: [ processAnnotation := WeakValueDictionary new ]
]

{ #category : #accessing }
BlProcess >> task [
	^ self annotation: #task
]

{ #category : #accessing }
BlProcess >> task: aValuable [
	^ self annotate: #task with: aValuable
]
