accessing
values: theValues keys: theKeys
	indices := self createIndex: theKeys.
	keys := self compact: theKeys indices: indices.
	values := self compact: theValues indices: indices