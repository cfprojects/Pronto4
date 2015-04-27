<cftry>	
	
	<cfif not isdefined("url.p")>
		<cfthrow message="Sorry, you gotta have something to delete.">
	</cfif>
	<cfset session.app.deleteProject(url.p)>
	<cflocation url="projects.cfm" addtoken="false">
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>


