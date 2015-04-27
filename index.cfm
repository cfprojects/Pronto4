<cfimport prefix="ui" taglib="layouts"/>
<ui:basic>
	<cfoutput><div id="welcome" class="welcome">Welcome to Pronto #session.user.getFirstName()# #session.user.getLastName()#</div></cfoutput>
</ui:basic>