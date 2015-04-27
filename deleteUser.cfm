<cftry>	
	
	<cfif not isdefined("url.u")>
		<cfthrow message="Sorry, you gotta have something to delete.">
	</cfif>
	<cfset session.app.deleteUser(url.u)>
	<cflocation url="users.cfm" addtoken="false">
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>


