<cftry>
	<!--- Some basic validation --->
	<cfif not isdefined("form.clientname")>
		<cfthrow message="Sorry, you have to enter a project name.<br>">
	</cfif>
	
	<cfif form.clientname eq ''>
		<cfthrow message="Sorry, a client name is mandatory.">
	</cfif>
	<cfif form.address1 eq ''>
		<cfthrow message="Sorry, a client address is mandatory.">
	</cfif>
	<cfif form.city eq ''>
		<cfthrow message="Sorry, a client city is mandatory.">
	</cfif>
	<cfif form.city eq ''>
		<cfthrow message="Sorry, a client state is mandatory.">
	</cfif>
	<cfif form.zip eq ''>
		<cfthrow message="Sorry, a client zip is mandatory.">
	</cfif>
	
	<!--- Save my project --->
	<cfif isdefined("form.c")>
		<cfset session.app.updateClient(FORM)>
	<cfelse>
		<cfset session.app.addClient(FORM,session.user.getUserId())>
	</cfif>
	<cflocation url="clients.cfm" addtoken="false">
	
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>