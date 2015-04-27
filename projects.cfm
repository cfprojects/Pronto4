<cftry>	

	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		<cfset qProjects = session.user.getUserProjects()>
		<div class="headerDisplay">View Projects</div>
		<cfif qProjects.recordcount>
			<table width="700" id="itemGrid">
				<tr>
					<th>Project Name</th>
					<th>Client</th>
					<th>&nbsp;</th>
				</tr>
				<cfoutput query="qProjects">
					<tr>
						<td>#projectName#</td>
						<td>#clientname#</td>
						<td nowrap="true">
							<a class="btnSmall" href="addEditProject.cfm?p=#projectid#" title="Edit #projectname#">Edit</a>
							<a class="btnSmall" href="deleteProject.cfm?p=#projectid#" title="Delete #projectname#">Delete</a>
						</td>
					</tr>
				</cfoutput>
			</table>
			
		<cfelse>
			<div class="normalText"><br />Sorry, there are no records to display at this time.</div>
		</cfif>
		
		<br /><br />
		<a class="btnLarge" href="addEditProject.cfm">Create New Project</a>
	</ui:basic>
<cfcatch type="any">
	<cfinclude template="error_msg.cfm">
</cfcatch>
</cftry>