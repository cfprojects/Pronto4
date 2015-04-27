<cftry>
	<cfif not isdefined("form.isComplete")>
		<cfthrow message="Sorry, you submitted the wrong data.">
	</cfif>
	<cfparam name="url.i" default="true">
	<cfset session.app.setComplete(form.isComplete,url.i)/>
	<cflocation url="tasks.cfm" addtoken="false">
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>	
</cftry>