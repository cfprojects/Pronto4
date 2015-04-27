
<cftry>
	<cfimport prefix="ui" taglib="layouts"/>
	<ui:basic>
		
		<cfhtmlhead text="
			<script src='SpryAssets/SpryValidationTextField.js' type='text/javascript'></script> 
			<link href='SpryAssets/SpryValidationTextField.css' rel='stylesheet' type='text/css' /> 				
		">
		<cfparam name="url.c" default="0" type="numeric"/>
		<cfset qClient = session.app.getClientForEdit(url.c)>
		
		<div class="headerDisplay"><cfif url.c eq 0>Add<cfelse>Edit</cfif> Client</div>
		<form action="saveClient.cfm" method="post">
		<table>
			<cfif url.c><cfoutput><input type="hidden" name="c" value="#qClient.Clientid#"/></cfoutput></cfif>
			<tr class="row">
				<td class="cell">Client Name:</td>
				<td class="rcell">
					<div id="ClientNameField">
						<cfoutput><input type="text" id="ClientNameField" name="clientName" size="30" maxlength="350" class="" value="#qClient.ClientName#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter a client name</span>
					</div>
				</td>
			</td>
			<tr class="row">
				<td class="cell">Address:</td>
				<td class="rcell">
					<div id="ClientAddressField">
						<cfoutput><input type="text" id="ClientAddressField" name="address1" size="30" maxlength="250" class="" value="#qClient.address1#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter the client's address</span>
					</div>
					<cfoutput><input type="text" name="address2" size="30" maxlength="250" class="" value="#qClient.address2#"/></cfoutput>
				</td>
			</td>
			<tr class="row">
				<td class="cell">City:</td>
				<td class="rcell">
					<div id="CityField">
						<cfoutput><input type="text" id="CityField" name="city" size="30" maxlength="150" class="" value="#qClient.city#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter the client's city</span>
					</div>
				</td>
			</td>
			<tr class="row">
				<td class="cell">State:</td>
				<td class="rcell">
					<div id="StateField">
						<cfoutput><input type="text" id="StateField" name="state" size="30" maxlength="150" class="" value="#qClient.state#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter the client's state</span>
					</div>
				</td>
			</td>
			<tr class="row">
				<td class="cell">Zip:</td>
				<td class="rcell">
					<div id="ZipField">
						<cfoutput><input type="text" id="ZipField" name="zip" size="30" maxlength="150" class="" value="#qClient.zip#"/></cfoutput>
						<span class="textfieldRequiredMsg">Please enter the client's zip</span>
					</div>
				</td>
			</td>
			<tr class="row">
				<td colspan="2"><input type="submit" value="Save Client"/></td>
			</tr>
		</table>
		</form>
		<script language="javascript">
			var ClientNameField = new Spry.Widget.ValidationTextField("ClientNameField");
			var ClientAddressField = new Spry.Widget.ValidationTextField("ClientAddressField");
			var CityField = new Spry.Widget.ValidationTextField("CityField");
			var StateField = new Spry.Widget.ValidationTextField("StateField");
			var ZipField = new Spry.Widget.ValidationTextField("ZipField");
		</script>
	</ui:basic>
	<cfcatch type="any">
		<cfinclude template="error_msg.cfm">
	</cfcatch>
</cftry>