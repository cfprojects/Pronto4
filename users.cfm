<cftry>	

	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		<cfset qUsers = session.app.getUsers()>
		<div class="headerDisplay">View Users</div>
		<cfif qUsers.recordcount>
			<table width="700" id="itemGrid">
				<tr>
					<th>Name</th>
					<th>Email</th>
					<th>Last Login</th>
					<th>&nbsp;</th>
				</tr>
				<cfoutput query="qUsers">
					<tr>
						<td>#firstname# #lastname#</td>
						<td>#email#</td>
						<td>#dateformat(lastvisit,"m/d/yyyy")#</td>
						<td>
							<a class="btnSmall" href="addEditUser.cfm?u=#Userid#" title="Edit #Username#">Edit</a>
							<a class="btnSmall" href="deleteUser.cfm?u=#Userid#" title="Delete #Username#">Delete</a>
						</td>
					</tr>
				</cfoutput>
			</table>
			
		<cfelse>
			<div class="normalText"><br />Sorry, there are no records to display at this time.</div>
		</cfif>
		
		<br /><br />
		<a class="btnLarge" href="addEditUser.cfm">Create New User</a>
	</ui:basic>
<cfcatch type="any">
	<cfinclude template="error_msg.cfm">
</cfcatch>
</cftry>