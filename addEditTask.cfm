
<cftry>
	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		
		<cfhtmlhead text="
			<script src='SpryAssets/SpryValidationTextField.js' type='text/javascript'></script> 
			<link href='SpryAssets/SpryValidationTextField.css' rel='stylesheet' type='text/css' /> 			
			<script src='SpryAssets/SpryValidationTextarea.js' type='text/javascript'></script> 
			<link href='SpryAssets/SpryValidationTextarea.css' rel='stylesheet' type='text/css' /> 				
		">
		<cfparam name="url.t" default="0" type="numeric"/>
		<cfset qTask = session.app.getTaskForEdit(url.t)>
		<cfset qGetTypes = session.app.getTypes('priority')>
		<cfset qGetProjects = session.user.getUserProjects()>
		
		<div class="headerDisplay"><cfif url.t eq 0>Add<cfelse>Edit</cfif> Task</div>
		
		<cfform action="saveTask.cfm?#cgi.query_String#" method="post">
		<table>
		<cfif url.t><cfoutput><input type="hidden" name="t" value="#qTask.taskid#"/></cfoutput></cfif>
			<tr class="row">
				<td class="cell">Task:</td>
				<td class="rcell">
					<span id="TaskTextField">
						<cfoutput><cftextarea id="taskText" name="taskText" required="true" message="You have to enter in a task." cols="70" rows="5">#qTask.taskText#</cftextarea></cfoutput>
						<span class="textareaRequiredMsg">Please enter the Task's text</span>
					</span>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Start Date:</td>
				<td class="rcell">
						<cfif qtask.startdate eq ''>
							<cfinput type="datefield" name="startdate"  size="30" maxlength="250" validate="date" value="#dateformat(now(),'m/d/yyyy')#"/>
						<cfelse>
							<cfinput type="datefield" name="startdate"  size="30" maxlength="250" validate="date" value="#dateformat(qTask.startdate,'m/d/yyyy')#"/>
						</cfif>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Due Date:</td>
				<td class="rcell">
						<cfif qtask.startdate eq ''>
							<cfinput type="datefield" name="duedate"  size="30" maxlength="250" validate="date" class="" value="#dateformat(now(),'m/d/yyyy')#"/>
						<cfelse>
							<cfinput type="datefield" name="duedate" size="30" maxlength="250" class="" validate="date" value="#dateformat(qTask.duedate,'m/d/yyyy')#"/>
						</cfif>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Hours:</td>
				<td class="rcell">
					<cfoutput><input type="text" id="HoursField" name="hours" size="30" maxlength="150" class="" value="#val(qTask.hours)#"/></cfoutput>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Project:</td>
				<td class="rcell">
					<select name="projectid">
						<cfoutput query="qGetProjects">
							<option value="#projectid#" <cfif qTask.projectid eq projectid>selected</cfif>>#projectname#
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Priority:</td>
				<td class="rcell">
					<select name="priority">
						<cfoutput query="qGetTypes">
							<option value="#typeid#" <cfif qTask.priority eq typeid>selected</cfif>>#sDesc#
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Description (optional):</td>
				<td class="rcell">
					<span id="TaskTextField">
						<cfoutput><cftextarea id="taskText" name="optionalDesc" cols="90" rows="20">#qTask.optionalDesc#</cftextarea></cfoutput>
						<span class="textareaRequiredMsg">Please enter the Task's text</span>
					</span>
				</td>
			</tr>
			<tr class="row">
				<td class="cell"></td>
				<td class="rcell">
					<input type="checkbox" name="isComplete" id="isComplete" value="1" class=""/><label for="isComplete">Mark Complete?
				</td>
			</tr>
			<tr class="row">
				<td colspan="2"><input type="submit" value="Save Task"/></td>
			</tr>
			
		</table>
		</cfform>
		<script language="javascript">
			var TaskTextField = new Spry.Widget.ValidationTextarea("TaskTextField");
		</script>
	</ui:basic>
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>