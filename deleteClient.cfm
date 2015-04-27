<cftry>	
	
	<cfif not isdefined("url.c")>
		<cfthrow message="Sorry, you gotta have something to delete.">
	</cfif>
	<cfset session.app.deleteClient(url.c)>
	<cflocation url="clients.cfm" addtoken="false">
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>


