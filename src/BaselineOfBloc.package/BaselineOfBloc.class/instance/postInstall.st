as yet unclassified
postInstall
	|pragmas|
	pragmas := OrderedCollection new.
	Object withAllSubclassesDo: [:each |
		pragmas addAll: (Pragma allNamed: #spartaPostLoad in: each) ].
	pragmas do: [ :each | each method methodClass baseClass perform: each method selector ]