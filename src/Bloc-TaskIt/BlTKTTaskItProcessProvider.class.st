Class {
	#name : #BlTKTTaskItProcessProvider,
	#superclass : #TKTTaskItProcessProvider,
	#category : #'Bloc-TaskIt-Processes'
}

{ #category : #'instance-creation' }
BlTKTTaskItProcessProvider >> createProcessDoing: aValuable named: aName [
	^ (self processClass send: #value to: aValuable)
		annotate: #task with: aValuable;
		name: aName;
		priority: Processor userSchedulingPriority - 5;
		run
]

{ #category : #accessing }
BlTKTTaskItProcessProvider >> processClass [
	^ BlTKTProcess
]

{ #category : #accessing }
BlTKTTaskItProcessProvider >> processPriority [
	<return: #Integer>
	^ self subclassResponsibility
]
