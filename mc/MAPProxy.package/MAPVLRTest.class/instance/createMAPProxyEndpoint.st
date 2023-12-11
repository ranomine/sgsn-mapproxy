initialization
createMAPProxyEndpoint

	"Create a TCAP endpoint."

	tcap := TCAPServiceEndPoint new.
	tcap networkService: conn.
	tcap asn1Model: MAPProxy asn1Model.

	"Create Server accepting Osmo/IPA multiplexed messages"
	MAPProxy asn1Model: tcap asn1Model.
	mapProxy := MAPProxyVLR new.
	mapProxy endPoint: tcap.
	mapProxy vlrNumber: self vlrNumber.
	mapProxy mscNumber: self mscNumber.
	"server serverDelegate: (MAPProxyServerDelegate new mapProxy: mapProxy; yourself)."

	"Configure IMSI -> E212/E214 mapping and which operation to use"
	mapProxy addGT: (MAPProxyGT new
			 imsiRange: '23410.*' asRegex;
			 replaceStart: '447802';
			 operationForAuthentication: MAPProxyAuthenticationV2Operation;
			 yourself).

	"Start all of it"
	conn start