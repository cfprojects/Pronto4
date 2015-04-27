
<cftry>
	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		
		<cfhtmlhead text="
			<script src='SpryAssets/SpryValidationTextField.js' type='text/javascript'></script> 
			<link href='SpryAssets/SpryValidationTextField.css' rel='stylesheet' type='text/css' /> 				
		">
		<cfparam name="url.p" default="0" type="numeric"/>
		<cfset qProject = session.app.getProjectForEdit(url.p)>
		<cfset qClientList = session.user.getClientList()>
		
		<div class="headerDisplay"><cfif url.p eq 0>Add<cfelse>Edit</cfif> Project</div>
		<form action="saveProject.cfm" method="post">
		<table>
			<cfif url.p><cfoutput><input type="hidden" name="p" value="#qProject.projectid#"/></cfoutput></cfif>
			<tr class="row">
				<td class="cell">Project Name:</td>
				<td class="rcell">
					<div id="projectNameField">
						<cfoutput><input type="text" id="projectNameField" name="projectName" size="30" maxlength="250" class="" value="#qProject.projectName#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter a project name</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Clients:</td>
				<td class="rcell">
					<select name="clientid">
						<cfif isdefined("url.p")>
							<cfoutput query="qClientList">
								<option value="#clientid#" <cfif qProject.clientid eq clientid>selected</cfif>>#clientname#
							</cfoutput>
						<cfelse>
							<cfoutput query="qClientList">
								<option value="#clientid#">#clientname#
							</cfoutput>
						</cfif>
					</select>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Bill Rate:</td>
				<td class="rcell">
					<div id="billrateField">
						<cfoutput>$<input type="text" id="billrateField" name="billrate" size="10" maxlength="250" class="" value="#numberformat(val(qProject.billrate),"0.00")#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter a bill rate</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td colspan="2"><input type="submit" value="Save Project"/></td>
			</tr>
		</table>
		</form>
		<script language="javascript">
			var projectNameField = new Spry.Widget.ValidationTextField("projectNameField");
			var billrateField = new Spry.Widget.ValidationTextField("billrateField");
		</script>
	</ui:basic>
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>