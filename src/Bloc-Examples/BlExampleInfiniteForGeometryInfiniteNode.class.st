Class {
	#name : #BlExampleInfiniteForGeometryInfiniteNode,
	#superclass : #BlExampleInfiniteForGeometryNode,
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #'api - instantiation' }
BlExampleInfiniteForGeometryInfiniteNode >> create [
	| anInfinite |

	anInfinite := BlExampleInfiniteForGeometryElement new.
	anInfinite dataSource nodes: self nodes.
	anInfinite constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	^ anInfinite
]
