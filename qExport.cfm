<cfimport prefix="ui" taglib="layouts"/>
<ui:basic>
	<cftry>	
		<cfset completedTasks = session.user.getUserCompletedTasks()/>
		<a href="javascript:void(0);" onclick="document.frm.submit()" class="btnLarge">Process Quicken File</a><br />			
		<form action="processQuicken.cfm" name="frm" method="post" target="_blank">
			<table width="900" style="border:1px solid #000000;" id="itemGrid">
				<tr>	
					<th>&nbsp;</th>
					<th>Task Name</th>
					<th>Project</th>
					<th>Start Date</th>
					<th>Due Date</th>
					<th>Hours</th>
					<th>Priority</th>
				</tr>
				<cfset totalfunds = 0/>
					<cfoutput query="completedTasks">
							<tr>
								<td valign="top">
									<input type="checkbox" name="invoiceMe" value="#taskid#" checked/>							
								</td>
								<td valign="top">#session.app.formatText(tasktext)#</td>
								<td valign="top">#projectname#</td>
								<td valign="top">#dateformat(startdate,"mm/dd/yyyy")#</td>
								<td valign="top" <cfif duedate lt now() and isComplete neq 1>style="color:red;"</cfif>>#dateformat(duedate,"mm/dd/yyyy")#</td>
								<td valign="top">#hours#</td>
								<td valign="top">#priorityname#</td>
							</tr>
						<cfset totalFunds = totalFunds + (hours * billrate)>
					</cfoutput>
					<cfoutput>
						<tr>
							<td colspan="7"><span style="float:right;">Total Potential Funds: <strong>#variables.totalfunds#</strong></span></td>
						</tr>
					</cfoutput>
			</table>
		</form><br />
		<a href="javascript:void(0);" onclick="document.frm.submit()" class="btnLarge">Process Quicken File</a>
		<cfcatch type="any">
			<cfinclude template="error_msg.cfm">
		</cfcatch>
	</cftry>
</ui:basic>