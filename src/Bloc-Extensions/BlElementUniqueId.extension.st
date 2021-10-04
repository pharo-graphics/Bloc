Extension { #name : #BlElementUniqueId }

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId >> gtAllUniqueIdsFor: aView [
	<gtView>

	^ aView forward
		title: 'All Unique Ids';
		priority: 4;
		object: [ self class ];
		view: #gtAllUniqueIdsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId class >> gtAllUniqueIdsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'All Unique Ids';
		priority: 0.9;
		items: [
			BlElementUniqueId allSubclasses
				reject: [ :eachIdClass | eachIdClass isAbstract ]
				thenCollect: [ :eachIdClass | eachIdClass uniqueInstance ] ];
		column: 'Id' text: [ :eachUniqueId | eachUniqueId class name ];
		column: 'Name' text: [ :eachUniqueId | eachUniqueId asSymbol ];
		column: 'Description' text: [ :eachUniqueId | eachUniqueId description ]
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId >> gtAllUsagesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'All Usages';
		priority: 2;
		object: [ self class ];
		view: #gtAllUsagesFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId class >> gtAllUsagesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'All Usages';
		priority: 0.2;
		object: [ self gtReferences ];
		view: #gtItemsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId class >> gtSimilarUniqueIdsFor: aView [
	<gtView>

	^ aView forward
		title: 'Similar Unique Ids';
		priority: 0.8;
		object: [ ((self allSuperclassesIncluding: BlElementUniqueId) select: [ :eachIdClass | eachIdClass isAbstract ]) first ];
		view: #gtAllUniqueIdsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId >> gtSimilarUniqueIdsFor: aView [
	<gtView>

	^ aView forward
		title: 'Similar Unique Ids';
		priority: 3;
		object: [ self class ];
		view: #gtSimilarUniqueIdsFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId >> gtUsagesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Usages';
		priority: 1;
		object: [ self class ];
		view: #gtUsagesFor:
]

{ #category : #'*Bloc-Extensions' }
BlElementUniqueId class >> gtUsagesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Usages';
		priority: 0.1;
		object: [ self gtReferences & (#gtExample gtPragmas not) ];
		view: #gtItemsFor:
]
