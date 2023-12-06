initialization
runVLRTest

	| tcap imsi gt op |
	"Create a connection class"
	conn := SCCPNetworkServiceOsmoDirect new
		        hostname: '10.26.0.69' port: 15004;
		        token: 'thnode';
		        yourself.

	"Create a TCAP endpoint."
	tcap := TCAPServiceEndPoint new.
	tcap networkService: conn.
	tcap asn1Model: MAPProxy asn1Model.

	"Create Server accepting Osmo/IPA multiplexed messages"
	MAPProxy asn1Model: tcap asn1Model.
	mapProxy := MAPProxyVLR new.
	mapProxy endPoint: tcap.
	mapProxy vlrNumber: '14174000031'.
	mapProxy mscNumber: '14174000032'.
	"server serverDelegate: (MAPProxyServerDelegate new mapProxy: mapProxy; yourself)."

	"Configure IMSI -> E212/E214 mapping and which operation to use"
	mapProxy addGT: (MAPProxyGT new
			 imsiRange: '23410.*' asRegex;
			 replaceStart: '447802';
			 operationForAuthentication: MAPProxyAuthenticationV2Operation;
			 yourself).

	"Start all of it"
	conn start.

	imsi := '234105619121251'.
	gt := mapProxy gtForIMSI: imsi.
	op := MAPProxyUpdateLocationOperation new.
	op
		dialogue: mapProxy newDialogue;
		callingSCCPAddress: (mapProxy callingSCCPAddress: gt callingSSN);
		calledSCCPAddress: (mapProxy calledSCCPAddress: (gt prepare: imsi));
		imsi: imsi;
		mscNumber: mapProxy mscNumber;
		vlrNumber: mapProxy vlrNumber;
		onFailure: [ "self returnUpdateLocationFailureFor: aRequest on: aDelegate"
			 ];
		onSuccess: [ :result | "self
				returnUpdateLocationResultFor: aRequest
				with: op
				on: aDelegate
				result: result"
			 ];
		start.
