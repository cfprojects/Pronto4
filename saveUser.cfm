<cftry>
	<!--- Some basic validation --->
	<cfif not isdefined("form.firstname")>
		<cfthrow message="Sorry, you have to enter a first name.<br>">
	</cfif>
	<cfif not isdefined("form.lastname")>
		<cfthrow message="Sorry, you have to enter a last name.<br>">
	</cfif>
	<cfif not isdefined("form.username")>
		<cfthrow message="Sorry, you have to enter a user name.<br>">
	</cfif>
	<cfif not isdefined("form.password")>
		<cfthrow message="Sorry, you have to enter a password<br>">
	</cfif>
	<!--- Save my project --->
	<cfif isdefined("form.u")>
		<cfset session.app.updateUser(FORM)>
	<cfelse>
		<cfset session.app.addUser(FORM)>
	</cfif>
	<cflocation url="users.cfm" addtoken="false">
	
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>