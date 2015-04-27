<cfimport prefix="ui" taglib="layouts"/>
<ui:basic>
	<cfhtmlhead text="
		<script src='SpryAssets/SpryValidationTextField.js' type='text/javascript'></script> 
		<link href='SpryAssets/SpryValidationTextField.css' rel='stylesheet' type='text/css' /> 			
	">
	<form action="index.cfm" method="post">
		<div class="row">
			<div class="cell">Username:</div>
			<div class="rcell">
				<div id="usernameField">
					<input type="text" id="usernameField" name="j_username" size="30" maxlength="20" class="" value=""/>	
					<span class="textfieldRequiredMsg">Please enter a username</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="cell">Password:</div>
			<div class="rcell">
				<span id="passwordField">
					<input type="password" id="passwordField" name="j_password" size="30" maxlength="35" class="" value=""/>
					<span class="textfieldRequiredMsg">Please enter a password</span>
				</span>
			</div>
		</div>
		<input type="submit" value="Log In"/>
	</form>
	
	<script language="javascript">
		var usernameField = new Spry.Widget.ValidationTextField("usernameField");
		var passwordField = new Spry.Widget.ValidationTextField("passwordField");
	</script>
</ui:basic>