<cftry>	

	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		<cfset qClients = session.user.getUserClients()>
		<div class="headerDisplay">View Clients</div>
		<cfif qClients.recordcount>
			<table width="700" id="itemGrid">
				<tr>
					<th>Client Name</th>
					<th>City</th>
					<th>State</th>
					<th nowrap="true">&nbsp;</th>
				</tr>
				<cfoutput query="qClients">
					<tr>
						<td>#ClientName#</td>
						<td>#city#</td>
						<td>#State#</td>
						<td nowrap="true">
							<a class="btnSmall" href="addEditClient.cfm?c=#clientid#" title="Edit #clientname#">Edit</a>
							<a class="btnSmall" href="deleteClient.cfm?c=#clientid#" title="Delete #clientname#">Delete</a>
						</td>
					</tr>
				</cfoutput>
			</table>
			
		<cfelse>
			<div class="normalText"><br />Sorry, there are no records to display at this time.</div>
		</cfif>
		
		<br /><br />
		<a class="btnLarge" href="addEditClient.cfm">Create New Client</a>
	</ui:basic>
<cfcatch type="any">
	<cfinclude template="error_msg.cfm">
</cfcatch>
</cftry>
