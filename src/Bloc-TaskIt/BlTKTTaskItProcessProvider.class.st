Class {
	#name : #BlTKTTaskItProcessProvider,
	#superclass : #TKTTaskItProcessProvider,
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #'instance-creation' }
BlTKTTaskItProcessProvider >> createProcessDoing: aValuable named: aName [
	^ (self processClass send: #value to: aValuable)
		annotate: #task with: aValuable;
		name: aName;
		priority: self processPriority;
		run
]

{ #category : #accessing }
BlTKTTaskItProcessProvider >> processClass [
	^ BlTktProcess
]

{ #category : #accessing }
BlTKTTaskItProcessProvider >> processPriority [
	<return: #Integer>
	^ self subclassResponsibility
]
