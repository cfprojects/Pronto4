<cftry>
	<!--- Some basic validation --->
	<cfif not isdefined("form.tasktext")>
		<cfthrow message="Sorry, you have to enter task text.<br>">
	</cfif>
	<cfif not isdefined("form.startdate")>
		<cfthrow message="Sorry, you have to enter a start date.<br>">
	</cfif>
	<cfif not isdefined("form.duedate")>
		<cfthrow message="Sorry, you have to enter a due date.<br>">
	</cfif>
	<cfif isdefined("form.hours") and NOT isNumeric(form.hours)>
		<cfthrow message="Sorry, you have to enter a valid number for hours.<br>">
	</cfif>
	<cfif form.tasktext eq ''>
		<cfthrow message="Sorry, you have to enter task text.<br>">
	</cfif>
	<cfif NOT isdefined("form.isComplete")>
		<cfset form.isComplete = 0>
	</cfif>
	<!--- Save my project --->
	<cfif isdefined("form.t")>
		<cfset session.app.updateTask(FORM)>
	<cfelse>
		<cfset session.app.addTask(FORM,session.user.getUserId())>
	</cfif>
	<cflocation url="tasks.cfm?o=#session.o#&keyword=#session.keyword#&project=#session.project#&client=#session.client#" addtoken="false">
	
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>