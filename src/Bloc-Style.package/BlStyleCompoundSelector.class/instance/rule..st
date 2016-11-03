accessing
rule: aRule
	super rule: aRule.
	self selectors do: [ :item | item rule: aRule ]