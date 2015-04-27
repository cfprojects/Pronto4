<cftry>	
	<cfparam name="url.o" default="priorityASC" type="string"/>
	<cfparam name="url.keyword" default=""/>
	<cfparam name="url.project" default="0"/>
	<cfparam name="url.client" default="0"/>
	<cflock scope="session" timeout="30">
		<cfset session.keyword = url.keyword/>
		<cfset session.project = url.project/>
		<cfset session.client = url.client/>
		<cfset session.o = url.o/>
	</cflock>
	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		<cfhtmlhead text="
			<script src='SpryAssets/SpryCollapsiblePanel.js' type='text/javascript'></script> 		
		">
		<cfset qTasks = session.user.getUserTasks(url.o,url.keyword,url.project,url.client)/>
		<cfset hoursSum = session.user.getUserTasksSum()/>
		<cfset getClients = session.user.getClientList()/>
		<cfset getProjects = session.user.getUserProjects()/>
		<cfset totalFunds = 0>
		<div class="headerDisplay">View Tasks</div><br />
		<a class="btnLarge" style="margin:0px 0px 0px 0px;" href="addEditTask.cfm">Create New Task</a><br />
		<div id="Search" class="CollapsibleContent">
			<div id="searchid" style="margin:0px 0px 0px 0px; width:884px;" class="CollapsiblePanelTab">Search Panel</div>
				<div class="CollapsiblePanelContent">
					<table  id="itemGrid">
					<tr><td nowrap="true">
						<form action="<cfoutput>#cgi.SCRIPT_NAME#</cfoutput>" method="get">
							Search for <cfoutput><input type="text" name="keyword" size="35" class="" value="#url.keyword#"/>&nbsp;&nbsp;&nbsp;</cfoutput>
							<select name="project">
								<option value="0">Choose a project
								<cfoutput query="getProjects"><option value="#projectid#" <cfif url.project eq projectid>selected</cfif>>#projectname#</cfoutput>
							</select>&nbsp;&nbsp;&nbsp;
							<select name="client">
								<option value="0">Choose a client
								<cfoutput query="getClients"><option value="#clientid#" <cfif url.client eq clientid>selected</cfif>>#clientname#</cfoutput>
							</select>&nbsp;&nbsp;&nbsp;<input type="submit" value="GO">
						</form>
					</td></tr>
					</table>
				</div>
			</div>
		</div>
		<cfif qTasks.recordcount>
			<div id="taskDiv" spry:region="dsTasks">
			<table width="900" id="itemGrid">
				<tr>	
					<th>&nbsp;</th>
					<th>Task Name</th>
					<th><a href="tasks.cfm?o=<cfif url.o eq 'projectASC'>projectDESC<cfelse>projectASC</cfif>">Project</a></th>
					<th><a href="tasks.cfm?o=<cfif url.o eq 'sdateASC'>sdateDESC<cfelse>sdateASC</cfif>">Start Date</a></th>
					<th><a href="tasks.cfm?o=<cfif url.o eq 'ddateASC'>ddateDESC<cfelse>ddateASC</cfif>">Due Date</a></th>
					<th><a href="tasks.cfm?o=<cfif url.o eq 'hoursASC'>hoursDESC<cfelse>hoursASC</cfif>">Hours</a></th>
					<th><a href="tasks.cfm?o=<cfif url.o eq 'priorityASC'>priorityDESC<cfelse>priorityASC</cfif>">Priority</a></th>
					<th width="200">&nbsp;</th>
				</tr>
				<cfoutput query="qTasks">
					<cfif iscomplete neq 1>
					<form action="" method="post">
						<tr>
							<td valign="top">
								<cfif isComplete eq 0>
									<input type="checkbox" name="isComplete" value="#taskid#" onclick="this.form.action='updateComplete.cfm?i=true'; this.form.submit()"/>
								<cfelse>
									<input type="checkbox" name="isComplete" value="#taskid#" checked onclick="this.checked=true; this.form.action='updateComplete.cfm?i=false'; this.form.submit()"/>
								</cfif>
								
							</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#session.app.formatText(tasktext)#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#projectname#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#dateformat(startdate,"mm/dd/yyyy")#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif> <cfif duedate lt now() and isComplete neq 1>style="color:red;"</cfif>>#dateformat(duedate,"mm/dd/yyyy")#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#hours#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#priorityname#</td>
							<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>
								<cfif isComplete eq 1><cfelse>
									<a class="btnSmall" href="addEditTask.cfm?t=#Taskid#" title="Edit #tasktext#">Edit</a>
									<a class="btnSmall" href="deleteTask.cfm?t=#Taskid#" title="Delete #tasktext#">Delete</a>
								</cfif>
							</td>
						</tr>
					</form>
					<cfset totalFunds = totalFunds + (hours * billrate)>
					</cfif>
				</cfoutput>
				</table><br /><br />
			<div id="CompletedTasks" class="CollapsibleContent">
				<div id="completedTaskId" style="margin:0px 0px 0px 2px; width:884px;" class="CollapsiblePanelTab" onclick="updateStatusText()">Click to View Completed Tasks</div>
				<div class="CollapsiblePanelContent">
					<table width="900" id="itemGrid">
						<tr><td colspan="8">&nbsp;</td></tr>
						<cfoutput query="qTasks">
							<cfif iscomplete eq 1>
							<form action="" method="post">
								<tr>
									<td valign="top">
										<cfif isComplete eq 0>
											<input type="checkbox" name="isComplete" value="#taskid#" onclick="this.form.action='updateComplete.cfm?i=true'; this.form.submit()"/>
										<cfelse>
											<input type="checkbox" name="isComplete" value="#taskid#" checked onclick="this.checked=true; this.form.action='updateComplete.cfm?i=false'; this.form.submit()"/>
										</cfif>
										
									</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#tasktext#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#projectname#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#dateformat(startdate,"mm/dd/yyyy")#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif> <cfif duedate lt now() and isComplete neq 1>style="color:red;"</cfif>>#dateformat(duedate,"mm/dd/yyyy")#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#hours#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>#priorityname#</td>
									<td valign="top" <cfif isComplete eq 1>class="strikeIt"</cfif>>
										<cfif isComplete eq 1><cfelse>
											<a class="btnSmall" href="addEditTask.cfm?t=#Taskid#" title="Edit #tasktext#">Edit</a>
											<a class="btnSmall" href="deleteTask.cfm?t=#Taskid#" title="Delete #tasktext#">Delete</a>
										</cfif>
									</td>
								</tr>
							</form>
							<cfset totalFunds = totalFunds + (hours * billrate)>
							</cfif>
						</cfoutput>
					</table>
				</div>
			</div>
				<table width="900" id="itemGrid">
					<tr>
						<td valign="top" colspan="8">
							<strong>Total Hours:</strong> <cfoutput>#hoursSum#</cfoutput><br />
							<strong>Current Invoice Value:</strong> <cfoutput>#dollarFormat(totalFunds)#</cfoutput>
						</td>
					</tr>
				</table>
		<cfelse>
			<div class="normalText"><br />Sorry, there are no records to display at this time.</div>
		</cfif>
		
		<br /><br />
		<a class="btnLarge" href="addEditTask.cfm">Create New Task</a>
		
		<script type="text/javascript">
			var acc = new Spry.Widget.CollapsiblePanel("CompletedTasks", {contentIsOpen: false});
			var search = new Spry.Widget.CollapsiblePanel("Search", {contentIsOpen: false});
			
			function updateStatusText(){
				var ios = acc.isOpen();
				if(!ios){
					document.getElementById('completedTaskId').innerHTML = "Click to Close Completed Tasks";
				}
				else{
					document.getElementById('completedTaskId').innerHTML = "Click to View Completed Tasks";
				}
			}
		</script> 
	</ui:basic>
<cfcatch type="any">
	<cfinclude template="error_msg.cfm">
</cfcatch>
</cftry>
