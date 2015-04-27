<cftry>
	<!--- Some basic validation --->
	<cfif not isdefined("form.projectname")>
		<cfthrow message="Sorry, you have to enter a project name.<br>">
	</cfif>
	
	<!--- Save my project --->
	<cfif isdefined("form.p")>
		<cfset session.app.updateProject(FORM,session.user.getUserId())>
	<cfelse>
		<cfset session.app.addProject(FORM,session.user.getUserId())>
	</cfif>
	<cflocation url="projects.cfm" addtoken="false">
	
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>