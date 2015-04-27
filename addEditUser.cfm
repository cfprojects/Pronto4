
<cftry>
	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		
		<cfhtmlhead text="
			<script src='SpryAssets/SpryValidationTextField.js' type='text/javascript'></script> 
			<link href='SpryAssets/SpryValidationTextField.css' rel='stylesheet' type='text/css' /> 		
		">
		<cfparam name="url.u" default="0" type="numeric"/>
		<cfset qUser = session.app.getUserForEdit(url.u)>
		<cfset qGetTypes = session.app.getTypes('roles')>
		<cfset qGetProjects = session.app.getProjectsForUsers()>		
		<cfset qClientList = session.app.getClientListForUsers()>
		<div class="headerDisplay"><cfif url.u eq 0>Add<cfelse>Edit</cfif> User</div>
		<form action="saveUser.cfm" method="post">
		<table>
			<cfif url.u><cfoutput><input type="hidden" name="u" value="#qUser.Userid#"/></cfoutput></cfif>
			<tr class="row">
				<td class="cell">First Name:</td>
				<td class="rcell">
					<div id="FirstNameField">
						<cfoutput><input id="FirstNameField" type="text" name="firstname"  size="30" maxlength="250" class="" value="#qUser.firstname#"/></cfoutput>
						<span class="textfieldRequiredMsg">First Name is required</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Last Name:</td>
				<td class="rcell">
					<div id="LastNameField">
						<cfoutput><input id="LastNameField" type="type" name="lastname" size="30" maxlength="250" class="" value="#qUser.lastname#"/></cfoutput>
						<span class="textfieldRequiredMsg">Last Name is required</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Username:</td>
				<td class="rcell">
					<div id="UserNameField">
						<cfoutput><input id="UserNameField" type="type" name="username" size="30" maxlength="20" class="" value="#qUser.username#"/></cfoutput>
						<span class="textfieldRequiredMsg">Username is required</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Password:</td>
				<td class="rcell">
					<div id="PasswordField">
						<cfoutput><input id="PasswordField" type="type" name="password" size="30" maxlength="35" class="" value="#qUser.password#"/></cfoutput>
						<span class="textfieldRequiredMsg">Password is required</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Email:</td>
				<td class="rcell">
					<div id="EmailField">
						<cfoutput><input id="EmailField" type="type" name="email" size="30" maxlength="350" class="" value="#qUser.email#"/></cfoutput>
						<span class="textfieldRequiredMsg">Email is required</span>
					</div>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Role:</td>
				<td class="rcell">
					<select name="role">
						<cfoutput query="qGetTypes">
							<option value="#typeid#" <cfif qUser.role eq typeid>selected</cfif>>#sDesc#
						</cfoutput>
					</select>
				</td>
			</tr>
			<cfquery name="qUserProjects" datasource="#session.user.getDsn()#">
				select a.projectname, a.projectid, d.clientname
				from projects a 
						inner join userProjects b on a.projectid = b.projectid
						inner join clients d on d.clientid = a.clientid
				where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.u#"/>
			</cfquery>
			<cfquery name="qUserClients" datasource="#session.user.getDsn()#">
				select a.clientname, a.clientid
				from clients a 
						inner join userClients b on a.clientid=b.clientid
				where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.u#"/>
			</cfquery>
			<tr class="row">
				<td class="cell">Clients:</td>
				<td class="rcell">
					<select name="clientList" multiple size="5">
						<cfoutput query="qClientList">
							<option value="#clientid#" <cfif ListFind(ValueList(qUserClients.clientid),clientid)>selected</cfif>>#clientname#
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr class="row">
				<td class="cell">Projects:</td>
				<td class="rcell">
					<select name="projectList" size="5" multiple>
						<cfoutput query="qGetProjects">
							<option value="#projectid#" <cfif ListFind(ValueList(qUserProjects.projectid),projectid)>selected</cfif>>#projectname#
						</cfoutput>
					</select>
				</td>
			</tr>
			<tr class="row">
				<td colspan="2"><input type="submit" value="Save User"/></td>
			</tr>
		</table>
		</form>
		<script language="javascript">
			var FirstNameField = new Spry.Widget.ValidationTextField("FirstNameField");
			var LastNameField = new Spry.Widget.ValidationTextField("LastNameField");
			var UserNameField = new Spry.Widget.ValidationTextField("UserNameField");
			var PasswordField = new Spry.Widget.ValidationTextField("PasswordField");
			var EmailField = new Spry.Widget.ValidationTextField("EmailField");
		</script>
	</ui:basic>
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>