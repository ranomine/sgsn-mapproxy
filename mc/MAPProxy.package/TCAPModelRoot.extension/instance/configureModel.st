*MAPProxy
configureModel
"Extend the original method to update to specifics of how pharo13 accesses receiver of #packageNamed: message 
pharo7: RPackage organizer
pharo13: PackageOrganizer default
" 
	| col |
	col := OrderedCollection new.
	{ 'TCAP-Core' . 'ROS-Core' } do: [ :name | 
		(((PackageOrganizer default packageNamed: name) classes 
			select: [ :each | each inheritsFrom: ASN1BasicObject ])
			select: [ :each | each isAsn1ModelClass ]) collect: [ :cls |
				col add: (cls asn1TypeName -> cls asn1InstanceFactory) ] ].
	col.

	asn1Model applyMapping: col asDictionary
