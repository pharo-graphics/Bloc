private
ensureIceberg
	(Smalltalk hasClassNamed: #Iceberg)
		ifTrue: [ ^ self ].
		
	"Iceberg is not installed, installing..."
	Metacello new
		baseline: 'Iceberg';
		repository: 'github://pharo-vcs/iceberg-dev:0.4';
		load