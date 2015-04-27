<cftry>	
	
	<cfif not isdefined("url.t")>
		<cfthrow message="Sorry, you gotta have something to delete.">
	</cfif>
	<cfset session.app.deleteTask(url.t)>
	<cflocation url="tasks.cfm" addtoken="false">
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>


