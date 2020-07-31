
Install-module AzureADPreview

#Connect to Azure AD
$AzureAdCred = Get-Credential  
Connect-AzureAD -Credential $AzureAdCred



# Retrive role definitions
Get-AzureADMSPrivilegedRoleDefinition -ProviderId aadRoles -ResourceId <tenantId>

# Retrieve role assignments in AZ AD organization
Get-AzureADMSPrivilegedRoleAssignment -ProviderId "aadRoles" -ResourceId <tenantId>

# Retrieve roles for a particular user "My Roles" in AZ AD
Get-AzureADMSPrivilegedRoleAssignment -ProviderId "aadRoles" -ResourceId "<tenantID>" -Filter "subjectId eq $MIMObserver.id"

# Retrieve all role assignments for a particular role. RoleDefinitionId is the ID that is returners by the previous cmdlet.
Get-AzureADMSPrivilegedRoleAssignment -ProviderId "aadRoles" -ResourceId "<tenantID>" -Filter "roleDefinitionId eq '$Reader.Id'"

# To create an elegible assignment
Open-AzureADMSPrivilegedRoleAssignmentRequest -ProviderId 'aadRoles' -ResourceId '<tenantId>' -RoleDefinitionId $Reader -SubjectId $MIMObserver.id -Type 'adminAdd' -AssignmentState 'Permanent' -schedule $schedule -reason "reason"


# if creating a schedule time
$setting = Get-AzureADMSPrivilegedRoleSetting -ProviderId 'aadRoles' -Filter "roleDefinitionId eq 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'"
$setting.UserMemberSetting.justificationRule = '{"required":false}'


# Activate a role Assignment
Open-AzureADMSPrivilegedRoleAssignmentRequest -ProviderId 'aadRoles' -ResourceId '<tenantid>' -RoleDefinitionId $Reader -SubjectId $MIMObserver.id -Type 'UserAdd' -AssignmentState 'Active' -schedule $schedule -reason "justified reason"


Set-AzureADMSPrivilegedRoleSetting -ProviderId 'aadRoles' -Id 'ff518d09-47f5-45a9-bb32-71916d9aeadf' -ResourceId '3f5887ed-dd6e-4821-8bde-c813ec508cf9' -RoleDefinitionId '2387ced3-4e95-4c36-a915-73d803f93702' -UserMemberSettings $setting