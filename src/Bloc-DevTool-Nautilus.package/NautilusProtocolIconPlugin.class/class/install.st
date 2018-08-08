installation
install
	| aNode |
	<script: 'self install'>
	
	self uninstall.

	link := MetaLink new
		metaObject: [
			| aProtocolName |
			aProtocolName := thisContext sender arguments first.
			NautilusProtocolIconPlugin categoryIconFor: aProtocolName ];
		control: #instead;
		selector: #value.
		
	aNode := (CategoryWidget >> #categoryIconFor:) ast statements last value.
	aNode link: link